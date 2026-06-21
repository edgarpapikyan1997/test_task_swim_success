import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../logic/pace_input_constants.dart';
import '../../logic/pace_time_utils.dart';

class PaceSlider extends StatelessWidget {
  const PaceSlider({
    super.key,
    required this.totalSeconds,
    required this.accentColor,
    required this.onChanged,
  });

  final int totalSeconds;
  final Color accentColor;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: accentColor,
            inactiveTrackColor: AppColors.divider,
            thumbColor: accentColor,
            overlayColor: accentColor.withValues(alpha: 0.12),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            min: PaceInputConstants.minTotalSeconds.toDouble(),
            max: PaceInputConstants.maxTotalSeconds.toDouble(),
            value: totalSeconds.toDouble(),
            onChanged: (value) => onChanged(value.round()),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        _TickLabels(accentColor: accentColor),
      ],
    );
  }
}

class _TickLabels extends StatelessWidget {
  const _TickLabels({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final range = PaceInputConstants.maxTotalSeconds -
        PaceInputConstants.minTotalSeconds;

    return SizedBox(
      height: 20,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              for (final tick in PaceInputConstants.sliderTickSeconds)
                _TickLabel(
                  label: formatPaceLabel(tick),
                  offsetFraction:
                      (tick - PaceInputConstants.minTotalSeconds) / range,
                  maxWidth: constraints.maxWidth,
                  color: accentColor,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TickLabel extends StatelessWidget {
  const _TickLabel({
    required this.label,
    required this.offsetFraction,
    required this.maxWidth,
    required this.color,
  });

  final String label;
  final double offsetFraction;
  final double maxWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const labelWidth = 36.0;
    final left = (maxWidth * offsetFraction) - (labelWidth / 2);

    return Positioned(
      left: left.clamp(0, maxWidth - labelWidth),
      child: SizedBox(
        width: labelWidth,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.8)),
        ),
      ),
    );
  }
}
