import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

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

  static const BoxDecoration editingDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.accent, width: 1.5),
    ),
  );
}
