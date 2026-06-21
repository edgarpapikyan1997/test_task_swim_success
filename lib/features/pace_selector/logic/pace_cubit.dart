import 'package:flutter_bloc/flutter_bloc.dart';

import 'pace_input_constants.dart';
import 'pace_state.dart';
import 'pace_time_utils.dart';

class PaceCubit extends Cubit<PaceState> {
  PaceCubit() : super(const PaceInputState());

  PaceInputState get _input => state as PaceInputState;

  void incrementMinutes() {
    if (_input.minutes >= PaceInputConstants.maxMinutes) {
      return;
    }
    emit(_input.copyWith(minutes: _input.minutes + 1));
  }

  void decrementMinutes() {
    if (_input.minutes <= PaceInputConstants.minMinutes) {
      return;
    }
    emit(_input.copyWith(minutes: _input.minutes - 1));
  }

  void incrementSeconds() {
    if (_input.seconds >= PaceInputConstants.maxSeconds) {
      if (_input.minutes < PaceInputConstants.maxMinutes) {
        emit(_input.copyWith(minutes: _input.minutes + 1, seconds: 0));
      }
      return;
    }
    emit(_input.copyWith(seconds: _input.seconds + 1));
  }

  void decrementSeconds() {
    if (_input.seconds <= PaceInputConstants.minSeconds) {
      if (_input.minutes > PaceInputConstants.minMinutes) {
        emit(_input.copyWith(minutes: _input.minutes - 1, seconds: 59));
      }
      return;
    }
    emit(_input.copyWith(seconds: _input.seconds - 1));
  }

  void setMinutes(int value) {
    emit(_input.copyWith(minutes: clampMinutes(value)));
  }

  void setSeconds(int value) {
    emit(_input.copyWith(seconds: clampSeconds(value)));
  }
}
