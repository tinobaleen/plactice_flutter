package llmClient

import (
	v1 "bff/internal/gen/to_llm/v1"
	pb_client "bff/internal/gen/to_llm/v1/v1connect"
	"context"
	"crypto/tls"
	"net"
	"net/http"

	"connectrpc.com/connect"
	"golang.org/x/net/http2"
)

type WrapedClient struct {
	client pb_client.LlmServiceClient
}

func NewClient() *WrapedClient {
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

	return &WrapedClient{
		client: base_client,
	}
}

func (c *WrapedClient) Send(ctx context.Context, content string) (*connect.ServerStreamForClient[v1.LlmResponse], error) {
	return c.client.LlmMessageRequest(ctx,
		&connect.Request[v1.LlmRequest]{
			Msg: &v1.LlmRequest{
				AllMessage: []*v1.Message{},
				NewMessage: &v1.Message{
					Message: content,
				},
			},
		},
	)
}
