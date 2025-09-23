from google.protobuf import empty_pb2 as _empty_pb2
from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from collections.abc import Iterable as _Iterable, Mapping as _Mapping
from typing import ClassVar as _ClassVar, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class Message(_message.Message):
    __slots__ = ("message",)
    MESSAGE_FIELD_NUMBER: _ClassVar[int]
    message: str
    def __init__(self, message: _Optional[str] = ...) -> None: ...

class LlmRequest(_message.Message):
    __slots__ = ("all_message", "new_message")
    ALL_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    NEW_MESSAGE_FIELD_NUMBER: _ClassVar[int]
    all_message: _containers.RepeatedCompositeFieldContainer[Message]
    new_message: Message
    def __init__(self, all_message: _Optional[_Iterable[_Union[Message, _Mapping]]] = ..., new_message: _Optional[_Union[Message, _Mapping]] = ...) -> None: ...

class Health(_message.Message):
    __slots__ = ("status", "ok")
    STATUS_FIELD_NUMBER: _ClassVar[int]
    OK_FIELD_NUMBER: _ClassVar[int]
    status: str
    ok: bool
    def __init__(self, status: _Optional[str] = ..., ok: _Optional[bool] = ...) -> None: ...

class LlmResponse(_message.Message):
    __slots__ = ("content",)
    CONTENT_FIELD_NUMBER: _ClassVar[int]
    content: Message
    def __init__(self, content: _Optional[_Union[Message, _Mapping]] = ...) -> None: ...
