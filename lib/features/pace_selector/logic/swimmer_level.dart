import 'pace_level_constants.dart';

enum SwimmerLevel {
  elite,
  advanced,
  intermediate,
  beginner;

  String get displayName => switch (this) {
        SwimmerLevel.elite => 'Elite',
        SwimmerLevel.advanced => 'Advanced',
        SwimmerLevel.intermediate => 'Intermediate',
        SwimmerLevel.beginner => 'Beginner',
      };

  static const List<SwimmerLevel> tabOrder = [
    SwimmerLevel.elite,
    SwimmerLevel.advanced,
    SwimmerLevel.intermediate,
    SwimmerLevel.beginner,
  ];
}

SwimmerLevel swimmerLevelFromSeconds(int totalSeconds) {
  if (totalSeconds <= PaceLevelConstants.eliteMaxSeconds) {
    return SwimmerLevel.elite;
  }
  if (totalSeconds <= PaceLevelConstants.advancedMaxSeconds) {
    return SwimmerLevel.advanced;
  }
  if (totalSeconds <= PaceLevelConstants.intermediateMaxSeconds) {
    return SwimmerLevel.intermediate;
  }
  return SwimmerLevel.beginner;
}
