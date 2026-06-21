import 'package:flutter/material.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/swimmer_level.dart';
import '../theme/pace_ui_constants.dart';
import '../theme/swimmer_level_colors.dart';

class PaceContinueButton extends StatelessWidget {
  const PaceContinueButton({
    super.key,
    required this.level,
    required this.isLoading,
    required this.isEnabled,
    required this.onPressed,
  });

  final SwimmerLevel level;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = SwimmerLevelColors.buttonFor(level);

    return Semantics(
      button: true,
      enabled: isEnabled && !isLoading,
      label: isLoading ? 'Submitting pace' : 'Continue',
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.primaryButtonHeight,
        child: FilledButton(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            disabledBackgroundColor: backgroundColor.withValues(
              alpha: PaceUiConstants.disabledButtonAlpha,
            ),
            foregroundColor: Colors.black,
            disabledForegroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(PaceUiConstants.continueButtonRadius),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: AppSizes.loadingSpinnerSize,
                  height: AppSizes.loadingSpinnerSize,
                  child: CircularProgressIndicator(
                    strokeWidth: AppSizes.loadingSpinnerStroke,
                    color: Colors.black,
                  ),
                )
              : const Text('Continue', style: AppTextStyles.buttonLabel),
        ),
      ),
    );
  }
}
