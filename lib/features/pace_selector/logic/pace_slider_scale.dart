import 'pace_input_constants.dart';

/// Non-linear slider mapping that gives the 1:30–2:00 band more track space.
abstract final class PaceSliderScale {
  static const int _emphasizedStart = 90;
  static const int _emphasizedEnd = 120;
  static const double _emphasizedWeight = 2.5;
  static const double _beginnerCompressWeight = 0.4;

  static double get _weightBeforeEmphasis =>
      (_emphasizedStart - PaceInputConstants.minTotalSeconds).toDouble();

  static double get _emphasizedSpanWeight =>
      (_emphasizedEnd - _emphasizedStart) * _emphasizedWeight;

  static double get _weightAfterEmphasis =>
      (PaceInputConstants.maxTotalSeconds - _emphasizedEnd) *
      _beginnerCompressWeight;

  static double get _totalWeight =>
      _weightBeforeEmphasis + _emphasizedSpanWeight + _weightAfterEmphasis;

  static double secondsToFraction(int seconds) {
    final clamped = seconds.clamp(
      PaceInputConstants.minTotalSeconds,
      PaceInputConstants.maxTotalSeconds,
    );
    return _weightAtSeconds(clamped) / _totalWeight;
  }

  static int fractionToSeconds(double fraction) {
    final target = (fraction.clamp(0.0, 1.0)) * _totalWeight;

    if (target <= _weightBeforeEmphasis) {
      return (PaceInputConstants.minTotalSeconds +
              (target / _weightBeforeEmphasis) * _weightBeforeEmphasis)
          .round();
    }

    final afterFirst = target - _weightBeforeEmphasis;
    if (afterFirst <= _emphasizedSpanWeight) {
      return (_emphasizedStart +
              (afterFirst / _emphasizedSpanWeight) *
                  (_emphasizedEnd - _emphasizedStart))
          .round();
    }

    final afterSecond = afterFirst - _emphasizedSpanWeight;
    return (_emphasizedEnd +
            (afterSecond / _weightAfterEmphasis) *
                (PaceInputConstants.maxTotalSeconds - _emphasizedEnd))
        .round();
  }

  static double _weightAtSeconds(int seconds) {
    if (seconds <= _emphasizedStart) {
      return (seconds - PaceInputConstants.minTotalSeconds).toDouble();
    }
    if (seconds <= _emphasizedEnd) {
      return _weightBeforeEmphasis +
          (seconds - _emphasizedStart) * _emphasizedWeight;
    }
    return _weightBeforeEmphasis +
        _emphasizedSpanWeight +
        (seconds - _emphasizedEnd) * _beginnerCompressWeight;
  }
}
