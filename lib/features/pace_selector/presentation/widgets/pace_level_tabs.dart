import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/swimmer_level.dart';
import '../theme/pace_ui_constants.dart';
import '../theme/swimmer_level_colors.dart';

class PaceLevelTabs extends StatelessWidget {
  const PaceLevelTabs({super.key, required this.activeLevel});

  final SwimmerLevel activeLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final level in SwimmerLevel.tabOrder)
          _LevelTab(
            label: level.displayName,
            isActive: level == activeLevel,
            accentColor: SwimmerLevelColors.accentFor(level),
          ),
      ],
    );
  }
}

class _LevelTab extends StatelessWidget {
  const _LevelTab({
    required this.label,
    required this.isActive,
    required this.accentColor,
  });

  final String label;
  final bool isActive;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? accentColor : AppColors.textMuted;

    return Semantics(
      label: '$label level',
      selected: isActive,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.tabLabel.copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: color,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            height: PaceUiConstants.levelTabUnderlineHeight,
            width: PaceUiConstants.levelTabUnderlineWidth,
            color: isActive ? accentColor : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
