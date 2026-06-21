import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.color = AppColors.accent});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizes.loadingSpinnerSize,
        height: AppSizes.loadingSpinnerSize,
        child: CircularProgressIndicator(
          strokeWidth: AppSizes.loadingSpinnerStroke,
          color: color,
        ),
      ),
    );
  }
}
