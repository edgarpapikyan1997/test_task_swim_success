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
    _emitTime(_input.minutes + 1, _input.seconds);
  }

  void decrementMinutes() {
    if (_input.minutes <= PaceInputConstants.minMinutes) {
      return;
    }
    _emitTime(_input.minutes - 1, _input.seconds);
  }

  void incrementSeconds() {
    if (_input.seconds >= PaceInputConstants.maxSeconds) {
      if (_input.minutes < PaceInputConstants.maxMinutes) {
        _emitTime(_input.minutes + 1, 0);
      }
      return;
    }
    _emitTime(_input.minutes, _input.seconds + 1);
  }

  void decrementSeconds() {
    if (_input.seconds <= PaceInputConstants.minSeconds) {
      if (_input.minutes > PaceInputConstants.minMinutes) {
        _emitTime(_input.minutes - 1, 59);
      }
      return;
    }
    _emitTime(_input.minutes, _input.seconds - 1);
  }

  void setMinutes(int value) {
    _emitTime(clampMinutes(value), _input.seconds);
  }

  void setSeconds(int value) {
    _emitTime(_input.minutes, clampSeconds(value));
  }

  void setTotalSeconds(int value) {
    final clamped = clampTotalSeconds(value);
    final (minutes, seconds) = secondsToMinutesAndSeconds(clamped);
    emit(PaceInputState(minutes: minutes, seconds: seconds));
  }

  void _emitTime(int minutes, int seconds) {
    final clamped = clampTotalSeconds(totalSeconds(minutes, seconds));
    final (m, s) = secondsToMinutesAndSeconds(clamped);
    emit(PaceInputState(minutes: m, seconds: s));
  }
}
