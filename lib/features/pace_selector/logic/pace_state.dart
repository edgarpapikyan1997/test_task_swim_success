import 'package:equatable/equatable.dart';

import 'pace_input_data.dart';
import 'swimmer_level.dart';

sealed class PaceState extends Equatable {
  const PaceState(this.input);

  final PaceInputData input;

  int get minutes => input.minutes;
  int get seconds => input.seconds;
  int get totalSecondsValue => input.totalSecondsValue;
  SwimmerLevel get swimmerLevel => input.swimmerLevel;

  @override
  List<Object?> get props => [input];
}

final class PaceIdle extends PaceState {
  const PaceIdle([super.input = const PaceInputData()]);
}

final class PaceSubmitting extends PaceState {
  const PaceSubmitting(super.input);
}

final class PaceSubmitSuccess extends PaceState {
  const PaceSubmitSuccess(super.input);
}

final class PaceSubmitError extends PaceState {
  const PaceSubmitError(super.input, this.message);

  final String message;

  @override
  List<Object?> get props => [input, message];
}
