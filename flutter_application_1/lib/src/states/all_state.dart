import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/src/gen/to_client/v1/to_client.pbserver.dart';
import 'package:namer_app/src/widgets/chatMessage.dart';
import '../gen/to_client/v1/to_client.pb.dart' as $pb;




class AllState {
  final String current;
  final int count;
  final List<ChatMessage> chatMessages = [];



  AllState({required this.current ,required this.count,required List<ChatMessage>? chatMessages}){
    if (chatMessages != null) {
      this.chatMessages.addAll(chatMessages);
    }
  } 

  AllState copyWith({String? current, int? count, List<ChatMessage>? chatMessages}) {
     if (chatMessages != null) {
      this.chatMessages.clear();
      this.chatMessages.addAll(chatMessages);
     }
    return AllState(count: count ?? this.count,
                    current: current ?? this.current,
                    chatMessages: this.chatMessages,
                    );
  }
}

