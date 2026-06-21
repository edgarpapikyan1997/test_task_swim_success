import 'package:flutter/material.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'inline_editable_digit.dart';

class PaceDigitColumn extends StatelessWidget {
  const PaceDigitColumn({
    super.key,
    required this.value,
    required this.label,
    required this.onIncrement,
    required this.onDecrement,
    required this.onValueSubmitted,
    required this.maxLength,
    required this.semanticLabel,
  });

  final int value;
  final String label;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<int> onValueSubmitted;
  final int maxLength;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ChevronButton(
          icon: Icons.keyboard_arrow_up,
          onPressed: onIncrement,
          semanticLabel: 'Increase $label',
        ),
        InlineEditableDigit(
          value: value,
          maxLength: maxLength,
          semanticLabel: semanticLabel,
          onSubmitted: onValueSubmitted,
        ),
        _ChevronButton(
          icon: Icons.keyboard_arrow_down,
          onPressed: onDecrement,
          semanticLabel: 'Decrease $label',
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.xs),
        Text('TAP TO EDIT', style: AppTextStyles.caption),
      ],
    );
  }
}

class _ChevronButton extends StatelessWidget {
  const _ChevronButton({
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.textSecondary, size: 28),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: AppSizes.minTouchTarget,
          minHeight: AppSizes.minTouchTarget,
        ),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
