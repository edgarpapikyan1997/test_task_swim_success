import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/features/pace_selector/logic/swimmer_level.dart';

void main() {
  group('swimmerLevelFromSeconds', () {
    test('returns elite below 1:00', () {
      expect(swimmerLevelFromSeconds(45), SwimmerLevel.elite);
      expect(swimmerLevelFromSeconds(59), SwimmerLevel.elite);
    });

    test('returns advanced between 1:00 and 1:30', () {
      expect(swimmerLevelFromSeconds(60), SwimmerLevel.advanced);
      expect(swimmerLevelFromSeconds(90), SwimmerLevel.advanced);
    });

    test('returns intermediate between 1:30 and 2:00', () {
      expect(swimmerLevelFromSeconds(91), SwimmerLevel.intermediate);
      expect(swimmerLevelFromSeconds(120), SwimmerLevel.intermediate);
    });

    test('returns beginner above 2:00', () {
      expect(swimmerLevelFromSeconds(121), SwimmerLevel.beginner);
      expect(swimmerLevelFromSeconds(300), SwimmerLevel.beginner);
    });
  });
}
