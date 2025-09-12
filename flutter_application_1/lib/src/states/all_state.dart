import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/src/gen/to_client/v1/to_client.pbserver.dart';
import '../gen/to_client/v1/to_client.pb.dart' as $pb;


class AllState {
  final String current;
  final int count;
  final List<ChatMessageResponse> messages = [];


  AllState({required this.current ,required this.count,required List<ChatMessageResponse>? messages}){
    if (messages != null) {
      this.messages.addAll(messages);
    }
  } 

  AllState copyWith({String? current, int? count, List<ChatMessageResponse>? messages}) {
     if (messages != null) {
      this.messages.clear();
      this.messages.addAll(messages);
     }
    return AllState(count: count ?? this.count,
                    current: current ?? this.current,
                    messages: this.messages,
                    );
  }
}

