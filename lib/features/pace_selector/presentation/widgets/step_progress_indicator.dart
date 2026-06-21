import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../theme/pace_ui_constants.dart';

class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.stepCount,
    required this.activeStep,
  });

  final int stepCount;
  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < stepCount; index++) ...[
          if (index > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StepSegment(isActive: index < activeStep),
          ),
        ],
      ],
    );
  }
}

class _StepSegment extends StatelessWidget {
  const _StepSegment({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PaceUiConstants.stepSegmentHeight,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.levelIntermediate
            : AppColors.stepIndicatorInactive,
        borderRadius: BorderRadius.circular(PaceUiConstants.stepSegmentRadius),
      ),
    );
  }
}
