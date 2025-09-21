package service

import (
	v1 "bff/internal/gen/to_client/v1"
	"context"
	"log/slog"
	"strconv"

	"fmt"

	connect "connectrpc.com/connect"
	"github.com/firebase/genkit/go/ai"
	"github.com/firebase/genkit/go/genkit"
)

// type ChatMesssageServiceHandler interface {
// 	MessageRequest(context.Context, *connect.Request[v1.ChatMessageRequest], *connect.ServerStream[v1.ChatMessageResponse]) error
// }

var (
	LLM, g, err = NewLLM()
	llm_exsits  bool
)

func init() {

	if err != nil {
		fmt.Println(err.Error())
	}

	llm_exsits = LLM != nil

}

type ChatService struct {
}

func (c *ChatService) MessageRequest(
	ctx context.Context,
	req *connect.Request[v1.ChatMessageRequest],
	stream *connect.ServerStream[v1.ChatMessageResponse],
) error {

	if c == nil {
		slog.Error("ChatService not Instance")
		return nil
	}

	fmt.Println("request start!!", req.Msg.GetContent())
	if llm_exsits == false {
		LLM, g, err = NewLLM()
	}

	if err != nil {
		stream.Send(&v1.ChatMessageResponse{
			MsgType: *v1.MessageType_SYSTEM_MESSAGE.Enum(),
			Content: err.Error(),
			ChatId:  "errorMessage",
		})
		return err
	}

	slog.Log(ctx, slog.LevelDebug, req.Msg.GetContent())

	resp, err := genkit.Generate(
		ctx,
		g,
		ai.WithModel(LLM),
		ai.WithPrompt(req.Msg.GetContent()),
		ai.WithTools(ai.NewTool(
			// Name
			"SerchEmployeeName",
			// Description
			"社員番号から氏名を取得する関数",
			func(ctx *ai.ToolContext, userName string) (string, error) {
				fmt.Println(userName, "<- fuaction called username")
				return "田中太郎", nil
			},
		)),
		ai.WithToolChoice(ai.ToolChoiceAuto),

		ai.WithStreaming(func(ctx context.Context, chank *ai.ModelResponseChunk) error {
			err := stream.Send(
				&v1.ChatMessageResponse{
					MsgType: v1.MessageType_SYSTEM_MESSAGE,
					ChatId:  strconv.Itoa(chank.Index),
					Content: chank.Text(),
				},
			)

			return err
		},
		),
	)

	if err != nil {
		slog.Error(err.Error())
		return err
	}

	finshMessage := resp.FinishMessage

	stream.Send(
		&v1.ChatMessageResponse{
			MsgType: v1.MessageType_HUMAN_MESSAGE,
			Content: finshMessage,
			ChatId:  "lastChatmessage",
		},
	)

	return nil
}
