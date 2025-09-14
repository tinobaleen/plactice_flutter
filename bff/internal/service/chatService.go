package service

import (
	v1 "bff/internal/gen/to_client/v1"
	"context"
	"fmt"
	"log/slog"
	"time"

	connect "connectrpc.com/connect"
)

// type ChatMesssageServiceHandler interface {
// 	MessageRequest(context.Context, *connect.Request[v1.ChatMessageRequest], *connect.ServerStream[v1.ChatMessageResponse]) error
// }

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

	messgae := req.Msg
	ticker := time.Tick(2 * time.Second)
	for i := 1; i < 10; i++ {
		<-ticker
		err := stream.Send(
			&v1.ChatMessageResponse{
				MsgType: *v1.MessageType_HUMAN_MESSAGE.Enum(),
				Content: fmt.Sprintf("%d :: %s", i, messgae),
				ChatId:  "sample",
			},
		)

		if err != nil {
			slog.Error(err.Error())
		}
	}

	return nil
}
