import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/features/pace_selector/logic/pace_slider_scale.dart';

void main() {
  group('PaceSliderScale', () {
    test('1:30–2:00 span is wider than linear mapping', () {
      const linearSpan = (120 - 90) / (240 - 30);
      final scaledSpan = PaceSliderScale.secondsToFraction(120) -
          PaceSliderScale.secondsToFraction(90);

      expect(scaledSpan, greaterThan(linearSpan));
    });

    test('round-trips seconds through fraction mapping', () {
      for (final seconds in [30, 70, 90, 105, 120, 180, 240]) {
        final fraction = PaceSliderScale.secondsToFraction(seconds);
        final restored = PaceSliderScale.fractionToSeconds(fraction);
        expect(restored, seconds);
      }
    });

    test('clamps out-of-range values', () {
      expect(PaceSliderScale.fractionToSeconds(-1), 30);
      expect(PaceSliderScale.fractionToSeconds(2), 240);
    });
  });
}
