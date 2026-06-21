import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../theme/pace_ui_constants.dart';

class PaceProgressBar extends StatelessWidget {
  const PaceProgressBar({
    super.key,
    this.progress = PaceUiConstants.onboardingProgress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: AppSizes.progressBarHeight,
        backgroundColor: AppColors.divider,
        color: AppColors.textSecondary,
      ),
    );
  }
}
