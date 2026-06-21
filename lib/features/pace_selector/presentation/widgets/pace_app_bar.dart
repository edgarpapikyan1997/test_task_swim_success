import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';

class PaceAppBar extends StatelessWidget {
  const PaceAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Semantics(
          label: 'Back',
          button: true,
          child: SizedBox(
            width: AppSizes.minTouchTarget,
            height: AppSizes.minTouchTarget,
            child: IconButton(
              // Placeholder: no prior screen in this isolated test-task flow.
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: const CircleBorder(
                  side: BorderSide(color: AppColors.textMuted, width: 1),
                ),
              ),
              icon: const Icon(
                Icons.chevron_left,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
