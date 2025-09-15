import 'package:connectrpc/connect.dart' as connect;
import 'package:connectrpc/protobuf.dart' as buf;
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protocol/connect.dart';
import 'package:namer_app/src/gen/to_client/v1/to_client.connect.client.dart';
import '../gen/to_client/v1/to_client.pb.dart' as $pb;

import 'dart:io';

final TranceProtClient = Transport(
  baseUrl: "http://10.0.2.2:8080",
  codec: const buf.ProtoCodec(),
  httpClient: createHttpClient(),
);



final chatClient = ChatMesssageServiceClient(TranceProtClient);
