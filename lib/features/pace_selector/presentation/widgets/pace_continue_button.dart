import 'package:flutter/material.dart';

import '../../logic/swimmer_level.dart';
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

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
          foregroundColor: Colors.black,
          disabledForegroundColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.black,
                ),
              )
            : const Text(
                'Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
