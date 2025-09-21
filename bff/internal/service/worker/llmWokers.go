package worker

import (
	"bff/internal/env"
	"context"
	"fmt"
	"log/slog"

	ai "github.com/firebase/genkit/go/ai"
	genkit "github.com/firebase/genkit/go/genkit"
	o_plgin "github.com/firebase/genkit/go/plugins/ollama"
)

type Woker[InputStruct, OutputStruct any] struct {
	InputChan  <-chan InputStruct
	OutputChan chan<- OutputStruct
	LlmModel   *ai.Model
	Tools      []ai.Tool
	genkit     *genkit.Genkit
	ctx        context.Context
}

func NewWorker[InputStruct, OutputStruct any](ctx context.Context, inputChan <-chan InputStruct, tools ...ai.Tool) (*Woker[InputStruct, OutputStruct], chan OutputStruct, error) {
	outChan := make(chan OutputStruct, env.AGENT_WORKER_COUNT)

	ollama := &o_plgin.Ollama{ServerAddress: env.OLLAMA_SERVER_ADDRESS, Timeout: env.OLLAMA_WAIT_TIME}

	g := genkit.Init(ctx, genkit.WithPlugins(ollama))

	model := ollama.DefineModel(g, o_plgin.ModelDefinition{
		Name: env.OLLAMA_MODEL_NAME,
		Type: "chat",
	}, &ai.ModelOptions{})

	newWorker := &Woker[InputStruct, OutputStruct]{
		InputChan:  inputChan,
		OutputChan: outChan,
		LlmModel:   &model,
		genkit:     g,
		ctx:        ctx,
		Tools:      tools,
	}

	return newWorker, outChan, nil
}

type res interface {
	ai.ModelResponse | ai.ModelResponseChunk
}

func (w *Woker[InputStruct, OutputStruct]) run(
	from func(input InputStruct) string,
	to func(result res) OutputStruct,
) error {

	if w == nil {
		return fmt.Errorf("Woker is not instanced")
	}

	for msg := range w.InputChan {

		userMessage := from(msg)

		result, err := genkit.Generate(
			w.ctx,
			w.genkit,
			ai.WithModel(*w.LlmModel),
			ai.WithPrompt(userMessage),
		)

		if err != nil {
			slog.ErrorContext(w.ctx, err.Error())
			return err
		}

		w.OutputChan <- result
	}

	return nil
}

type WokerHandler[InputStruct, OutputStruct any] struct {
	WokerCount int
	FanOutChan []chan OutputStruct
	WokerPool  []*Woker[InputStruct, OutputStruct]
	contexts   []context.Context
}

func FatroryWokers[Input, Output any]() (*WokerHandler[Input, Output], error) {

	var workers []*Woker[Input, Output]
	var fanouts []chan Output
	var contexts []context.Context
	fanin := make(chan Input, env.AGENT_WORKER_COUNT)
	mainContext := context.Background()

	for i := 0; i < env.AGENT_WORKER_COUNT; i++ {
		new_woker, fanout, err := NewWorker[Input, Output](mainContext, fanin)
		if err != nil {
			slog.Error(err.Error())
			return nil, err
		}

		workers = append(workers, new_woker)
		fanouts = append(fanouts, fanout)
		contexts = append(contexts, new_woker.ctx)
	}

	wokerHandler := &WokerHandler[Input, Output]{
		WokerCount: env.AGENT_WORKER_COUNT,
		FanOutChan: fanouts,
		WokerPool:  workers,
		contexts:   contexts,
	}

	return wokerHandler, nil
}
