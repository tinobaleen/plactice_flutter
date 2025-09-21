package ioinfra

import (
	connect "bff/internal/gen/to_client/v1/v1connect"
	service "bff/internal/service"
	"net/http"
)

func FatroryServer() (*http.ServeMux, error) {
	chatHandlerService := &service.ChatService{}

	mux := http.NewServeMux()
	path, hadler := connect.NewChatMesssageServiceHandler(chatHandlerService)

	mux.Handle(path, hadler)

	return mux, nil
}
