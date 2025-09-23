

## 基本となるサーバーを作成してmainで呼び出す。



Basic Server Usage
---


・使用するプロトコルはASGI
・Hipercornを使用
    ・HTTP2をサポートしているため
・connectrpc pythonを組み込むかテスト
・

"""
from connectrpc.request import RequestContext
from your_service_pb2 import HelloRequest, HelloResponse
from your_service_connect import HelloService, HelloServiceASGIApplication

class MyHelloService(HelloService):
    async def say_hello(self, request: HelloRequest, ctx: RequestContext) -> HelloResponse:
        return HelloResponse(message=f"Hello, {request.name}!")

# Create ASGI app
app = HelloServiceASGIApplication(MyHelloService())

# Run with any ASGI server like uvicorn and hypercorn:
# uvicorn server:app --port 8080
"""