import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exception.dart';
import '../data/repository/pace_repository.dart';
import 'pace_input_data.dart';
import 'pace_input_constants.dart';
import 'pace_state.dart';
import 'pace_time_utils.dart';

class PaceCubit extends Cubit<PaceState> {
  PaceCubit(this._repository) : super(const PaceIdle());

  final PaceRepository _repository;

  bool get isSubmitting => state is PaceSubmitting;

  void incrementMinutes() {
    if (isSubmitting || state.minutes >= PaceInputConstants.maxMinutes) {
      return;
    }
    _emitTime(state.minutes + 1, state.seconds);
  }

  void decrementMinutes() {
    if (isSubmitting || state.minutes <= PaceInputConstants.minMinutes) {
      return;
    }
    _emitTime(state.minutes - 1, state.seconds);
  }

  void incrementSeconds() {
    if (isSubmitting) {
      return;
    }
    if (state.seconds >= PaceInputConstants.maxSeconds) {
      if (state.minutes < PaceInputConstants.maxMinutes) {
        _emitTime(state.minutes + 1, 0);
      }
      return;
    }
    _emitTime(state.minutes, state.seconds + 1);
  }

  void decrementSeconds() {
    if (isSubmitting) {
      return;
    }
    if (state.seconds <= PaceInputConstants.minSeconds) {
      if (state.minutes > PaceInputConstants.minMinutes) {
        _emitTime(state.minutes - 1, 59);
      }
      return;
    }
    _emitTime(state.minutes, state.seconds - 1);
  }

  void setMinutes(int value) {
    if (isSubmitting) {
      return;
    }
    _emitTime(clampMinutes(value), state.seconds);
  }

  void setSeconds(int value) {
    if (isSubmitting) {
      return;
    }
    _emitTime(state.minutes, clampSeconds(value));
  }

  void setTotalSeconds(int value) {
    if (isSubmitting) {
      return;
    }
    final clamped = clampTotalSeconds(value);
    final (minutes, seconds) = secondsToMinutesAndSeconds(clamped);
    _emitIdle(PaceInputData(minutes: minutes, seconds: seconds));
  }

  Future<void> submitPace() async {
    if (isSubmitting) {
      return;
    }

    final input = state.input;
    emit(PaceSubmitting(input));

    try {
      await _repository.submitPace(input.totalSecondsValue);
      emit(PaceSubmitSuccess(input));
      emit(PaceIdle(input));
    } on NetworkException catch (error) {
      emit(PaceSubmitError(input, error.message));
    } catch (_) {
      emit(PaceSubmitError(input, 'Something went wrong. Please try again.'));
    }
  }

  void _emitTime(int minutes, int seconds) {
    final clamped = clampTotalSeconds(totalSeconds(minutes, seconds));
    final (m, s) = secondsToMinutesAndSeconds(clamped);
    _emitIdle(PaceInputData(minutes: m, seconds: s));
  }

  void _emitIdle(PaceInputData data) => emit(PaceIdle(data));
}
