import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/features/pace_selector/logic/pace_slider_zones.dart';

void main() {
  group('resolveZone', () {
    test('returns elite below first tick', () {
      expect(resolveZone(45), PaceSliderZone.elite);
      expect(resolveZone(69), PaceSliderZone.elite);
    });

    test('returns advanced between 1:10 and 1:30 ticks', () {
      expect(resolveZone(70), PaceSliderZone.advanced);
      expect(resolveZone(89), PaceSliderZone.advanced);
    });

    test('returns intermediate between 1:30 and 2:00 ticks', () {
      expect(resolveZone(90), PaceSliderZone.intermediate);
      expect(resolveZone(119), PaceSliderZone.intermediate);
    });

    test('returns beginner after 2:00 tick', () {
      expect(resolveZone(120), PaceSliderZone.beginner);
      expect(resolveZone(240), PaceSliderZone.beginner);
    });
  });

  group('fillRangeForZone', () {
    test('fills from track start in elite zone', () {
      expect(fillRangeForZone(PaceSliderZone.elite, 45), (30, 45));
    });

    test('fills from 2:00 tick in beginner zone', () {
      expect(fillRangeForZone(PaceSliderZone.beginner, 240), (120, 240));
    });

    test('fills from zone boundary in advanced zone', () {
      expect(fillRangeForZone(PaceSliderZone.advanced, 80), (70, 80));
    });
  });
}
