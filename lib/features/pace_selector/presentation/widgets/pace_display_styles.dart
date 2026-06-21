import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../theme/pace_ui_constants.dart';

abstract final class PaceDisplayStyles {
  static const TextStyle digit = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    height: 1,
  );

  static const TextStyle colon = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    height: 1,
  );

  static final BoxDecoration editingDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius:
        BorderRadius.circular(PaceUiConstants.digitBorderRadius),
    border: Border.all(
      color: AppColors.accent,
      width: PaceUiConstants.digitBorderWidth,
    ),
  );
}
