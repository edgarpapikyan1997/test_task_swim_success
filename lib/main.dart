import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/pace_selector/presentation/screens/pace_selector_screen.dart';

void main() {
  runApp(const SwimSuccessApp());
}

class SwimSuccessApp extends StatelessWidget {
  const SwimSuccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swim Success',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      home: const PaceSelectorScreen(),
    );
  }
}
