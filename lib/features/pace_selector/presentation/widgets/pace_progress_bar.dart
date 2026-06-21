import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class PaceProgressBar extends StatelessWidget {
  const PaceProgressBar({super.key, this.progress = 0.25});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 4,
        backgroundColor: AppColors.divider,
        color: AppColors.textSecondary,
      ),
    );
  }
}
