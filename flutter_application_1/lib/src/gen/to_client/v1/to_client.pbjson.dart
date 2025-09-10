// This is a generated file - do not edit.
//
// Generated from to_client.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = {
  '1': 'MessageType',
  '2': [
    {'1': 'SYSTEM_MESSAGE', '2': 0},
    {'1': 'HUMAN_MESSAGE', '2': 1},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlVHlwZRISCg5TWVNURU1fTUVTU0FHRRAAEhEKDUhVTUFOX01FU1NBR0UQAQ==');

@$core.Deprecated('Use chatMessageRequestDescriptor instead')
const ChatMessageRequest$json = {
  '1': 'ChatMessageRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 9, '10': 'chatId'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `ChatMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageRequestDescriptor = $convert.base64Decode(
    'ChJDaGF0TWVzc2FnZVJlcXVlc3QSFwoHY2hhdF9pZBgBIAEoCVIGY2hhdElkEhgKB2NvbnRlbn'
    'QYAiABKAlSB2NvbnRlbnQ=');

@$core.Deprecated('Use chatMessageResponseDescriptor instead')
const ChatMessageResponse$json = {
  '1': 'ChatMessageResponse',
  '2': [
    {
      '1': 'msg_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.conenctrpc.to_client.v1.MessageType',
      '10': 'msgType'
    },
    {'1': 'chat_id', '3': 2, '4': 1, '5': 9, '10': 'chatId'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `ChatMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageResponseDescriptor = $convert.base64Decode(
    'ChNDaGF0TWVzc2FnZVJlc3BvbnNlEj8KCG1zZ190eXBlGAEgASgOMiQuY29uZW5jdHJwYy50b1'
    '9jbGllbnQudjEuTWVzc2FnZVR5cGVSB21zZ1R5cGUSFwoHY2hhdF9pZBgCIAEoCVIGY2hhdElk'
    'EhgKB2NvbnRlbnQYAyABKAlSB2NvbnRlbnQ=');

const $core.Map<$core.String, $core.dynamic> ChatMesssageServiceBase$json = {
  '1': 'ChatMesssageService',
  '2': [
    {
      '1': 'MessageRequest',
      '2': '.conenctrpc.to_client.v1.ChatMessageRequest',
      '3': '.conenctrpc.to_client.v1.ChatMessageResponse',
      '6': true
    },
  ],
};

@$core.Deprecated('Use chatMesssageServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ChatMesssageServiceBase$messageJson = {
  '.conenctrpc.to_client.v1.ChatMessageRequest': ChatMessageRequest$json,
  '.conenctrpc.to_client.v1.ChatMessageResponse': ChatMessageResponse$json,
};

/// Descriptor for `ChatMesssageService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List chatMesssageServiceDescriptor = $convert.base64Decode(
    'ChNDaGF0TWVzc3NhZ2VTZXJ2aWNlEm0KDk1lc3NhZ2VSZXF1ZXN0EisuY29uZW5jdHJwYy50b1'
    '9jbGllbnQudjEuQ2hhdE1lc3NhZ2VSZXF1ZXN0GiwuY29uZW5jdHJwYy50b19jbGllbnQudjEu'
    'Q2hhdE1lc3NhZ2VSZXNwb25zZTAB');
