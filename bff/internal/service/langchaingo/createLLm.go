package langchaingo

import (
	"github.com/tmc/langchaingo/llms/ollama"
)

func GetOllama(modelName string) (*ollama.LLM, error) {
	if modelName == "" {
		modelName = "gpt-oss:20b"
	}
	llm, err := ollama.New(ollama.WithModel(modelName))
	if err != nil {
		return nil, err
	}
	return llm, nil
}
