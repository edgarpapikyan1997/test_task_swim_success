import 'pace_input_constants.dart';

int clampMinutes(int value) =>
    value.clamp(PaceInputConstants.minMinutes, PaceInputConstants.maxMinutes);

int clampSeconds(int value) =>
    value.clamp(PaceInputConstants.minSeconds, PaceInputConstants.maxSeconds);

int totalSeconds(int minutes, int seconds) => (minutes * 60) + seconds;
