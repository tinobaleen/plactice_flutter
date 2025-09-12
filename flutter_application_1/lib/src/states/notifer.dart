import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'all_state.dart';
import '../gen/to_client/v1/to_client.pb.dart';


class AllStateNotifier extends StateNotifier<AllState> {
  AllStateNotifier() : super(AllState(
    current: 'sakusaku',
    count: 1,
    messages: [],
  ));

  void nextCount() {
    state = state.copyWith(count: state.count +1);
  }

  void lastName() {
    state = state.copyWith(current: 'taisaku');
  }


  void appendMessage(ChatMessageResponse message) {

    state =  state.copyWith(messages: 
      [...state.messages, message]
    );
  }
}


final allStateProvider = StateNotifierProvider<AllStateNotifier, AllState>((ref) {
  return AllStateNotifier();
});