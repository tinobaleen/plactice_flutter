import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/src/widgets/chatMessage.dart';
import 'all_state.dart';
import 'package:namer_app/src/gen/to_client/v1/to_client.pb.dart';


class AllStateNotifier extends StateNotifier<AllState> {
  AllStateNotifier() : super(AllState(
    current: 'sakusaku',
    count: 1,
    chatMessages: [],
  ));

  void nextCount() {
    state = state.copyWith(count: state.count +1);
  }

  void allDelete(){
    state  = state.copyWith(chatMessages: []);
  }
  void lastName() {
    state = state.copyWith(current: 'taisaku');
  }

  void insertMessageWidet(Stream<ChatMessageResponse> stream) {
    var newMessage = ChatMessage(stream: stream);
    state = state.copyWith(chatMessages: [...state.chatMessages,newMessage]);
  }


  


}


final allStateProvider = StateNotifierProvider<AllStateNotifier, AllState>((ref) {
  return AllStateNotifier();
});