import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'all_state.dart';


class AllStateNotifier extends StateNotifier<AllState> {
  AllStateNotifier() : super(AllState(
    current: 'sakusaku',
    count: 1,
  ));

  void nextCount() {
    state = state.copyWith(count: state.count +1);
  }

  void lastName() {
    state = state.copyWith(current: 'taisaku');
  }
}


final allStateProvider = StateNotifierProvider<AllStateNotifier, AllState>((ref) {
  return AllStateNotifier();
});