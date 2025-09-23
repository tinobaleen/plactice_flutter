

genall: gen_llm gen_client
	echo "ok"
	



gen_llm:
	cd proto/to_llm/v1;  \
	buf generate --template buf.gen.client.yaml

gen_client:
	cd proto/to_client/v1;  \
	buf generate --template buf.gen.to_llm.yaml


	


runbff:
	cd bff  \
	go run cmd/main.go

runllm:
	cd services/llmServer;  \
	 .venv/Scripts/activate;  \
	python3 main.py
