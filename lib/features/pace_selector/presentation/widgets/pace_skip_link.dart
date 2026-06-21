import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PaceSkipLink extends StatelessWidget {
  const PaceSkipLink({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        "I don't know my pace, skip this",
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textSecondary,
        ),
      ),
    );
  }
}
