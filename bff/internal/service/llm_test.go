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
		ai.WithPrompt("現在のユーザーの氏名を取得してください。方法はgetCurrentUsernNameというToolで取得が可能です。"),
		ai.WithTools(
			ai.NewTool(
				"getUserName", "現在のユーザーの氏名を取得します。",
				func(ctx *ai.ToolContext, input string) (string, error) {
					fmt.Println("function calling getUserName=>", input)
					return "田中太郎", nil
				},
			),
		),
	)

	if err != nil {
		fmt.Println("err := ", err.Error())
		return
	}

	fmt.Println(resp.Text())
}
