# Generated Connect client code

from __future__ import annotations
from collections.abc import AsyncIterator
from collections.abc import Iterator
from collections.abc import Iterable
import aiohttp
import urllib3
import typing
import sys

from connectrpc.client_async import AsyncConnectClient
from connectrpc.client_sync import ConnectClient
from connectrpc.client_protocol import ConnectProtocol
from connectrpc.client_connect import ConnectProtocolError
from connectrpc.headers import HeaderInput
from connectrpc.server import ClientRequest
from connectrpc.server import ClientStream
from connectrpc.server import ServerResponse
from connectrpc.server import ServerStream
from connectrpc.server_sync import ConnectWSGI
from connectrpc.streams import StreamInput
from connectrpc.streams import AsyncStreamOutput
from connectrpc.streams import StreamOutput
from connectrpc.unary import UnaryOutput
from connectrpc.unary import ClientStreamingOutput

if typing.TYPE_CHECKING:
    # wsgiref.types was added in Python 3.11.
    if sys.version_info >= (3, 11):
        from wsgiref.types import WSGIApplication
    else:
        from _typeshed.wsgi import WSGIApplication

import to_llm_pb2

class LlmServiceClient:
    def __init__(
        self,
        base_url: str,
        http_client: urllib3.PoolManager | None = None,
        protocol: ConnectProtocol = ConnectProtocol.CONNECT_PROTOBUF,
    ):
        self.base_url = base_url
        self._connect_client = ConnectClient(http_client, protocol)
    def llm_message_reqeust(
        self, req: to_llm_pb2.LlmRequest,extra_headers: HeaderInput | None=None, timeout_seconds: float | None=None
    ) -> Iterator[to_llm_pb2.LlmResponse]:
        return self._llm_message_reqeust_iterator(req, extra_headers, timeout_seconds)

    def _llm_message_reqeust_iterator(
        self, req: to_llm_pb2.LlmRequest,extra_headers: HeaderInput | None=None, timeout_seconds: float | None=None
    ) -> Iterator[to_llm_pb2.LlmResponse]:
        stream_output = self.call_llm_message_reqeust(req, extra_headers)
        err = stream_output.error()
        if err is not None:
            raise err
        yield from stream_output
        err = stream_output.error()
        if err is not None:
            raise err

    def call_llm_message_reqeust(
        self, req: to_llm_pb2.LlmRequest,extra_headers: HeaderInput | None=None, timeout_seconds: float | None=None
    ) -> StreamOutput[to_llm_pb2.LlmResponse]:
        """Low-level method to call LlmMessageReqeust, granting access to errors and metadata"""
        url = self.base_url + "/grpc.to_llm.v1.LlmService/LlmMessageReqeust"
        return self._connect_client.call_server_streaming(
            url, req, to_llm_pb2.LlmResponse, extra_headers, timeout_seconds
        )


class AsyncLlmServiceClient:
    def __init__(
        self,
        base_url: str,
        http_client: aiohttp.ClientSession,
        protocol: ConnectProtocol = ConnectProtocol.CONNECT_PROTOBUF,
    ):
        self.base_url = base_url
        self._connect_client = AsyncConnectClient(http_client, protocol)

    def llm_message_reqeust(
        self, req: to_llm_pb2.LlmRequest,extra_headers: HeaderInput | None=None, timeout_seconds: float | None=None
    ) -> AsyncIterator[to_llm_pb2.LlmResponse]:
        return self._llm_message_reqeust_iterator(req, extra_headers, timeout_seconds)

    async def _llm_message_reqeust_iterator(
        self, req: to_llm_pb2.LlmRequest,extra_headers: HeaderInput | None=None, timeout_seconds: float | None=None
    ) -> AsyncIterator[to_llm_pb2.LlmResponse]:
        stream_output = await self.call_llm_message_reqeust(req, extra_headers)
        err = stream_output.error()
        if err is not None:
            raise err
        async with stream_output as stream:
            async for response in stream:
                yield response
            err = stream.error()
            if err is not None:
                raise err

    async def call_llm_message_reqeust(
        self, req: to_llm_pb2.LlmRequest,extra_headers: HeaderInput | None=None, timeout_seconds: float | None=None
    ) -> AsyncStreamOutput[to_llm_pb2.LlmResponse]:
        """Low-level method to call LlmMessageReqeust, granting access to errors and metadata"""
        url = self.base_url + "/grpc.to_llm.v1.LlmService/LlmMessageReqeust"
        return await self._connect_client.call_server_streaming(
            url, req, to_llm_pb2.LlmResponse, extra_headers, timeout_seconds
        )


@typing.runtime_checkable
class LlmServiceProtocol(typing.Protocol):
    def llm_message_reqeust(self, req: ClientRequest[to_llm_pb2.LlmRequest]) -> ServerStream[to_llm_pb2.LlmResponse]:
        ...

LLM_SERVICE_PATH_PREFIX = "/grpc.to_llm.v1.LlmService"

def wsgi_llm_service(implementation: LlmServiceProtocol) -> WSGIApplication:
    app = ConnectWSGI()
    app.register_server_streaming_rpc("/grpc.to_llm.v1.LlmService/LlmMessageReqeust", implementation.llm_message_reqeust, to_llm_pb2.LlmRequest)
    return app
