import 'package:equatable/equatable.dart';

import 'pace_input_constants.dart';
import 'pace_time_utils.dart';
import 'swimmer_level.dart';

final class PaceInputData extends Equatable {
  const PaceInputData({
    this.minutes = PaceInputConstants.defaultMinutes,
    this.seconds = PaceInputConstants.defaultSeconds,
  });

  final int minutes;
  final int seconds;

  int get totalSecondsValue => totalSeconds(minutes, seconds);

  SwimmerLevel get swimmerLevel =>
      swimmerLevelFromSeconds(totalSecondsValue);

  PaceInputData copyWith({int? minutes, int? seconds}) {
    return PaceInputData(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  List<Object?> get props => [minutes, seconds];
}
