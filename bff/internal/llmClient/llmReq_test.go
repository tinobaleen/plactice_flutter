package llmClient

import (
	v1 "bff/internal/gen/to_llm/v1"
	pb_client "bff/internal/gen/to_llm/v1/v1connect"
	"context"
	"crypto/tls"
	"fmt"
	"net"
	"net/http"
	"testing"
	"time"

	"connectrpc.com/connect"
	"golang.org/x/net/http2"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

func Test_Client(t *testing.T) {
	// クライアント作成
	client := NewClient()

	// 送信
	stream, err := client.Send(
		t.Context(), "hello world!!",
	)
	if err != nil {
		t.Error(err.Error())
		fmt.Println(err.Error())
		return
	}
	fmt.Println("is recived", stream.Receive())
	for stream.Receive() {
		msg := stream.Msg()

		fmt.Println(msg.Content.GetMessage())
	}
	// ストリーム受信
	fmt.Println("test done")
}

func Test_raw(t *testing.T) {

	h2cClient := &http.Client{
		Transport: &http2.Transport{
			// https:// 以外のスキーム (http://) を許可する
			AllowHTTP: true,
			// TLS接続の代わりに、通常のTCP接続を行うようにDIAL処理を上書きする
			DialTLSContext: func(ctx context.Context, network, addr string, cfg *tls.Config) (net.Conn, error) {
				var d net.Dialer
				// TLSハンドシェイクを無視して、平文のTCP接続を確立
				return d.DialContext(ctx, network, addr)
			},
		},
	}

	base_client := pb_client.NewLlmServiceClient(
		h2cClient,
		"http://localhost:8100",
		connect.WithGRPC(),
	)

	req := &v1.LlmRequest{
		AllMessage: []*v1.Message{},
		NewMessage: &v1.Message{
			Message: "from go lang client",
		},
	}

	res, err := base_client.HealthCheck(
		context.Background(),
		connect.NewRequest[emptypb.Empty](&emptypb.Empty{}),
	)

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Println("health ==", res.Msg.Ok)

	ctx, cancel := context.WithTimeout(t.Context(), 30*time.Second)

	defer cancel()

	stream, err := base_client.LlmMessageRequest(
		ctx,
		connect.NewRequest(req),
	)

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	defer stream.Close()

	fmt.Println("stream err => ", stream.Err())
	for stream.Receive() {
		msg := stream.Msg()
		fmt.Println(msg.Content.GetMessage())
	}

}
