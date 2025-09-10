//
//  Generated code. Do not modify.
//  source: to_client.proto
//

import "package:connectrpc/connect.dart" as connect;
import "to_client.pb.dart" as to_client;

abstract final class ChatMesssageService {
  /// Fully-qualified name of the ChatMesssageService service.
  static const name = 'conenctrpc.to_client.v1.ChatMesssageService';

  static const messageRequest = connect.Spec(
    '/$name/MessageRequest',
    connect.StreamType.server,
    to_client.ChatMessageRequest.new,
    to_client.ChatMessageResponse.new,
  );
}
