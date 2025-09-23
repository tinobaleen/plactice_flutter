from grpc.aio import Server,server
from typing import AsyncIterable,Iterable
from ..gen.to_llm_pb2_grpc import LlmServiceServicer,add_LlmServiceServicer_to_server
from ..gen import to_llm_pb2
import asyncio
# リフレクションモジュールをインポート
from grpc_reflection.v1alpha import reflection
from src.langGraph.ollama.createOllama import GetOllama

class LlmHandlerServiceImpl(LlmServiceServicer):
    model = GetOllama()
    async def LlmMessageRequest(self, request, context)-> AsyncIterable:
        
        
        req:to_llm_pb2.LlmRequest = request
        msg =  req.new_message
        
        async for chank in self.model.astream(input=msg.message):
    
            yield to_llm_pb2.LlmResponse(
                content= to_llm_pb2.Message(message=f"count={chank.content}")
            )
        print("message done")

       
    def HealthCheck(self, request, context):
        return to_llm_pb2.Health(
            status="ok",
            ok=True
        )






def FactoryAsyncServer(host:str = "localhost:8100")-> Server:
    #grpcの非同期サーバーを作成
    new_server = server()

    add_LlmServiceServicer_to_server(
        LlmHandlerServiceImpl(),new_server
    )
    SERVICE_NAMES = (
        to_llm_pb2.DESCRIPTOR.services_by_name['LlmService'].full_name,
        reflection.SERVICE_NAME,
    )
    reflection.enable_server_reflection(SERVICE_NAMES, new_server)
    portNumber = new_server.add_insecure_port(host)
    print(portNumber)
    return new_server







