import 'package:equatable/equatable.dart';

import 'pace_input_constants.dart';
import 'pace_time_utils.dart';
import 'swimmer_level.dart';

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

  int get totalSecondsValue => totalSeconds(minutes, seconds);

  SwimmerLevel get swimmerLevel =>
      swimmerLevelFromSeconds(totalSecondsValue);

  PaceInputState copyWith({int? minutes, int? seconds}) {
    return PaceInputState(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  List<Object?> get props => [minutes, seconds];
}
