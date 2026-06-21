import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color backgroundNavy = Color(0xFF0A0E1A);
  static const Color backgroundNavyDeep = Color(0xFF0D1220);
  static const Color backgroundGlow = Color(0xFF2A3F5F);

  static const Color background = backgroundNavy;
  static const Color surface = Color(0xFF1A2332);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF757575);
  static const Color accent = Color(0xFF4FC3F7);
  static const Color error = Color(0xFFCF6679);
  static const Color divider = Color(0xFF2C2C2C);

  /// Shared teal/mint used by the onboarding step indicator and Intermediate level.
  static const Color levelIntermediate = Color(0xFF66BB6A);
  static const Color stepIndicatorInactive = Color(0xFF3D4A5C);
}

abstract final class AppBackgroundDecoration {
  static BoxDecoration get radialNavy => BoxDecoration(
        color: AppColors.backgroundNavy,
        gradient: RadialGradient(
          center: const Alignment(0, -1.1),
          radius: 1.6,
          colors: [
            AppColors.backgroundGlow.withValues(alpha: 0.45),
            AppColors.backgroundNavy,
            AppColors.backgroundNavyDeep,
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
      );
}
