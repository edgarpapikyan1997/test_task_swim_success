import 'package:flutter/material.dart';

import 'pace_digit_column.dart';
import 'pace_display_styles.dart';

class PaceTimeDisplay extends StatelessWidget {
  const PaceTimeDisplay({
    super.key,
    required this.minutes,
    required this.seconds,
    required this.onMinutesChanged,
    required this.onSecondsChanged,
    required this.onIncrementMinutes,
    required this.onDecrementMinutes,
    required this.onIncrementSeconds,
    required this.onDecrementSeconds,
  });

  final int minutes;
  final int seconds;
  final ValueChanged<int> onMinutesChanged;
  final ValueChanged<int> onSecondsChanged;
  final VoidCallback onIncrementMinutes;
  final VoidCallback onDecrementMinutes;
  final VoidCallback onIncrementSeconds;
  final VoidCallback onDecrementSeconds;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaceDigitColumn(
          value: minutes,
          label: 'MIN',
          maxLength: 1,
          semanticLabel: 'Minutes',
          onIncrement: onIncrementMinutes,
          onDecrement: onDecrementMinutes,
          onValueSubmitted: onMinutesChanged,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 36),
          child: Text(':', style: PaceDisplayStyles.colon),
        ),
        PaceDigitColumn(
          value: seconds,
          label: 'SEC',
          maxLength: 2,
          semanticLabel: 'Seconds',
          onIncrement: onIncrementSeconds,
          onDecrement: onDecrementSeconds,
          onValueSubmitted: onSecondsChanged,
        ),
      ],
    );
  }
}
