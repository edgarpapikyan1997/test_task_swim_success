import 'pace_input_constants.dart';

int clampMinutes(int value) =>
    value.clamp(PaceInputConstants.minMinutes, PaceInputConstants.maxMinutes);

int clampSeconds(int value) =>
    value.clamp(PaceInputConstants.minSeconds, PaceInputConstants.maxSeconds);

int totalSeconds(int minutes, int seconds) => (minutes * 60) + seconds;

(int, int) secondsToMinutesAndSeconds(int total) {
  return (total ~/ 60, total % 60);
}

int clampTotalSeconds(int total) => total.clamp(
      PaceInputConstants.minTotalSeconds,
      PaceInputConstants.maxTotalSeconds,
    );

String formatPaceLabel(int totalSeconds) {
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}
