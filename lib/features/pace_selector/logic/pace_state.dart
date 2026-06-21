import 'package:equatable/equatable.dart';

import 'pace_input_constants.dart';

sealed class PaceState extends Equatable {
  const PaceState();

  @override
  List<Object?> get props => [];
}

final class PaceInputState extends PaceState {
  const PaceInputState({
    this.minutes = PaceInputConstants.defaultMinutes,
    this.seconds = PaceInputConstants.defaultSeconds,
  });

  final int minutes;
  final int seconds;

  PaceInputState copyWith({int? minutes, int? seconds}) {
    return PaceInputState(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  List<Object?> get props => [minutes, seconds];
}
