import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/pace_input_constants.dart';
import '../../logic/pace_slider_scale.dart';
import '../../logic/pace_time_utils.dart';
import '../theme/pace_ui_constants.dart';
import '../theme/swimmer_level_colors.dart';
import 'zone_slider_track_shape.dart';

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
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: SwimmerLevelColors.inactiveTrack,
            thumbColor: accentColor,
            overlayColor:
                accentColor.withValues(alpha: PaceUiConstants.accentOverlayAlpha),
            trackHeight: PaceUiConstants.sliderTrackHeight,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: PaceUiConstants.sliderThumbRadius,
            ),
            trackShape: ZoneSliderTrackShape(accentColor: accentColor),
          ),
          child: Slider(
            min: 0,
            max: 1,
            value: PaceSliderScale.secondsToFraction(totalSeconds),
            onChanged: (fraction) =>
                onChanged(PaceSliderScale.fractionToSeconds(fraction)),
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
    return SizedBox(
      height: PaceUiConstants.sliderTickAreaHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              for (final tick in PaceInputConstants.sliderTickSeconds)
                _TickLabel(
                  label: formatPaceLabel(tick),
                  offsetFraction: PaceSliderScale.secondsToFraction(tick),
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
    const horizontalInset = 16.0;
    final trackWidth = maxWidth - (horizontalInset * 2);
    final left = horizontalInset +
        (trackWidth * offsetFraction) -
        (PaceUiConstants.sliderTickLabelWidth / 2);

    return Positioned(
      left: left.clamp(
        0,
        maxWidth - PaceUiConstants.sliderTickLabelWidth,
      ),
      child: SizedBox(
        width: PaceUiConstants.sliderTickLabelWidth,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.tickLabel.copyWith(
            color: color.withValues(alpha: PaceUiConstants.tickLabelAlpha),
          ),
        ),
      ),
    );
  }
}
