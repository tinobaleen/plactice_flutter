package main

import (
	server "bff/internal/io_infra"
	"fmt"
	"net/http"

	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

func main() {
	// cmd.Execute()
	serverMux, err := server.FatroryServer()
	fmt.Println("start sever!!")
	if err != nil {
		panic("server not created")
	}

	http.ListenAndServe(
		"localhost:8080",
		h2c.NewHandler(serverMux, &http2.Server{}),
	)
}
