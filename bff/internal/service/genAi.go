package service

import (
	"context"

	"github.com/firebase/genkit/go/ai"
	genkit "github.com/firebase/genkit/go/genkit"
	o_plgin "github.com/firebase/genkit/go/plugins/ollama"
)

const (
	gpt_oss_20b = "gpt-oss:20b"
)

func NewLLM() (ai.Model, *genkit.Genkit, error) {
	ctx := context.Background()

	//initialize genkit with the google ai plugin

	ollama := &o_plgin.Ollama{ServerAddress: "http://127.0.0.1:11434", Timeout: 300}
	g := genkit.Init(ctx, genkit.WithPlugins(ollama))

	model := ollama.DefineModel(
		g,
		o_plgin.ModelDefinition{
			Name: gpt_oss_20b,
			Type: "chat", // "chat" or "generate"
		},
		nil,
	)

	return model, g, nil
}
