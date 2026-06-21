import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/swimmer_level.dart';
import '../theme/swimmer_level_colors.dart';

class PaceLevelDisplay extends StatelessWidget {
  const PaceLevelDisplay({super.key, required this.level});

  final SwimmerLevel level;

  @override
  Widget build(BuildContext context) {
    final accent = SwimmerLevelColors.accentFor(level);

    return Column(
      children: [
        Text('THAT PUTS YOU AT', style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        Text(
          level.displayName,
          style: AppTextStyles.headline.copyWith(color: accent),
        ),
      ],
    );
  }
}
