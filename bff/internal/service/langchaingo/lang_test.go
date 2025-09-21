package langchaingo

import (
	"context"
	"testing"
)

func Test_llm(t *testing.T) {
	llm, err := GetOllama("gpt-oss:20b")
	ctx := context.Background()

}
