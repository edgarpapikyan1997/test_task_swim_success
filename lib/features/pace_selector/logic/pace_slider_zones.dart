import 'pace_input_constants.dart';

enum PaceSliderZone {
  elite,
  advanced,
  intermediate,
  beginner,
}

PaceSliderZone resolveZone(int totalSeconds) {
  final ticks = PaceInputConstants.sliderTickSeconds;
  if (totalSeconds < ticks[0]) {
    return PaceSliderZone.elite;
  }
  if (totalSeconds < ticks[1]) {
    return PaceSliderZone.advanced;
  }
  if (totalSeconds < ticks[2]) {
    return PaceSliderZone.intermediate;
  }
  return PaceSliderZone.beginner;
}

(int startSeconds, int endSeconds) zoneBounds(PaceSliderZone zone) {
  final ticks = PaceInputConstants.sliderTickSeconds;
  return switch (zone) {
    PaceSliderZone.elite => (
        PaceInputConstants.minTotalSeconds,
        ticks[0],
      ),
    PaceSliderZone.advanced => (ticks[0], ticks[1]),
    PaceSliderZone.intermediate => (ticks[1], ticks[2]),
    PaceSliderZone.beginner => (ticks[2], PaceInputConstants.maxTotalSeconds),
  };
}

(int fillStartSeconds, int fillEndSeconds) fillRangeForZone(
  PaceSliderZone zone,
  int totalSeconds,
) {
  final (start, end) = zoneBounds(zone);
  return (start, totalSeconds.clamp(start, end));
}

double zoneStartFraction(PaceSliderZone zone, double minValue, double maxValue) {
  final (start, _) = zoneBounds(zone);
  return (start - minValue) / (maxValue - minValue);
}

double valueFraction(int totalSeconds, double minValue, double maxValue) {
  return (totalSeconds - minValue) / (maxValue - minValue);
}

List<double> tickFractions(double minValue, double maxValue) {
  return PaceInputConstants.sliderTickSeconds
      .map((tick) => valueFraction(tick, minValue, maxValue))
      .toList();
}
