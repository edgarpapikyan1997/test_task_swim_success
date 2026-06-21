import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../logic/swimmer_level.dart';

abstract final class SwimmerLevelColors {
  static Color accentFor(SwimmerLevel level) => switch (level) {
        SwimmerLevel.elite => const Color(0xFFFF9800),
        SwimmerLevel.advanced => const Color(0xFF42A5F5),
        SwimmerLevel.intermediate => AppColors.levelIntermediate,
        SwimmerLevel.beginner => AppColors.textPrimary,
      };

  static Color buttonFor(SwimmerLevel level) => switch (level) {
        SwimmerLevel.beginner => AppColors.textMuted,
        _ => accentFor(level),
      };

  static Color get inactiveTrack => AppColors.divider;
}
