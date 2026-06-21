import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/features/pace_selector/logic/pace_slider_zones.dart';

void main() {
  group('resolveZone', () {
    test('returns elite below first boundary', () {
      expect(resolveZone(45), PaceSliderZone.elite);
      expect(resolveZone(69), PaceSliderZone.elite);
    });

    test('returns advanced between 1:10 and 1:30 boundaries', () {
      expect(resolveZone(70), PaceSliderZone.advanced);
      expect(resolveZone(89), PaceSliderZone.advanced);
    });

    test('returns intermediate from 1:30 through 3:30 boundary', () {
      expect(resolveZone(90), PaceSliderZone.intermediate);
      expect(resolveZone(120), PaceSliderZone.intermediate);
      expect(resolveZone(209), PaceSliderZone.intermediate);
    });

    test('returns beginner after 3:30 boundary', () {
      expect(resolveZone(210), PaceSliderZone.beginner);
      expect(resolveZone(240), PaceSliderZone.beginner);
    });
  });

  group('fillRangeForZone', () {
    test('fills from track start in elite zone', () {
      expect(fillRangeForZone(PaceSliderZone.elite, 45), (30, 45));
    });

    test('fills from 3:30 boundary in beginner zone', () {
      expect(fillRangeForZone(PaceSliderZone.beginner, 225), (210, 225));
    });

    test('fills from zone boundary in advanced zone', () {
      expect(fillRangeForZone(PaceSliderZone.advanced, 80), (70, 80));
    });

    test('intermediate zone spans 1:30 to 3:30', () {
      final (start, end) = zoneBounds(PaceSliderZone.intermediate);
      expect(start, 90);
      expect(end, 210);
    });
  });
}
