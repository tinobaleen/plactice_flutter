// This is a generated file - do not edit.
//
// Generated from to_client.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'to_client.pb.dart' as $0;
import 'to_client.pbjson.dart';

export 'to_client.pb.dart';

abstract class ChatMesssageServiceBase extends $pb.GeneratedService {
  $async.Future<$0.ChatMessageResponse> messageRequest(
      $pb.ServerContext ctx, $0.ChatMessageRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'MessageRequest':
        return $0.ChatMessageRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'MessageRequest':
        return messageRequest(ctx, request as $0.ChatMessageRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      ChatMesssageServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ChatMesssageServiceBase$messageJson;
}
