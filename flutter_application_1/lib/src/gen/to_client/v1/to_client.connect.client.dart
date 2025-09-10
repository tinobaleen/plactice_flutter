//
//  Generated code. Do not modify.
//  source: to_client.proto
//

import "package:connectrpc/connect.dart" as connect;
import "to_client.pb.dart" as to_client;
import "to_client.connect.spec.dart" as specs;

extension type ChatMesssageServiceClient (connect.Transport _transport) {
  Stream<to_client.ChatMessageResponse> messageRequest(
    to_client.ChatMessageRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).server(
      specs.ChatMesssageService.messageRequest,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
