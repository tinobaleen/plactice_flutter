package service

import (
	"context"
	"fmt"
	"testing"

	ai "github.com/firebase/genkit/go/ai"
	"github.com/firebase/genkit/go/genkit"
)

func Test_genai(t *testing.T) {
	fmt.Println("gen llm start")

	llm, g, err := NewLLM()

	if err != nil {
		t.Error(err.Error())
		return
	}

	ctx := context.Background()

	resp, err := genkit.Generate(
		ctx, g,
		ai.WithModel(llm),
		ai.WithPrompt("こんにちは"),
	)
	if err != nil {
		fmt.Println("err := ", err.Error())
		return
	}

	fmt.Println(resp.Text())
}
