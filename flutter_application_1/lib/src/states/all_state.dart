import 'package:flutter_riverpod/flutter_riverpod.dart';



class AllState {
  final String current;
  final int count;

  AllState({required this.current ,required this.count});

  AllState copyWith({String? current, int? count}) {
    return AllState(count: count ?? this.count,
                    current: current ?? this.current,
                    );

  }
}

