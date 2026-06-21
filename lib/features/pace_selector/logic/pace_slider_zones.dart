import 'pace_input_constants.dart';

enum PaceSliderZone {
  elite,
  advanced,
  intermediate,
  beginner,
}

PaceSliderZone resolveZone(int totalSeconds) {
  final bounds = PaceInputConstants.sliderZoneBoundarySeconds;
  if (totalSeconds < bounds[0]) {
    return PaceSliderZone.elite;
  }
  if (totalSeconds < bounds[1]) {
    return PaceSliderZone.advanced;
  }
  if (totalSeconds < bounds[2]) {
    return PaceSliderZone.intermediate;
  }
  return PaceSliderZone.beginner;
}

(int startSeconds, int endSeconds) zoneBounds(PaceSliderZone zone) {
  final bounds = PaceInputConstants.sliderZoneBoundarySeconds;
  return switch (zone) {
    PaceSliderZone.elite => (
        PaceInputConstants.minTotalSeconds,
        bounds[0],
      ),
    PaceSliderZone.advanced => (bounds[0], bounds[1]),
    PaceSliderZone.intermediate => (bounds[1], bounds[2]),
    PaceSliderZone.beginner => (
        bounds[2],
        PaceInputConstants.maxTotalSeconds,
      ),
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
