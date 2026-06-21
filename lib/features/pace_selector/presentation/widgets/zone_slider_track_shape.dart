import 'package:flutter/material.dart';

import '../../logic/pace_input_constants.dart';
import '../../logic/pace_slider_zones.dart';
import '../theme/pace_ui_constants.dart';

class ZoneSliderTrackShape extends SliderTrackShape {
  const ZoneSliderTrackShape({
    required this.accentColor,
    required this.minValue,
    required this.maxValue,
  });

  final Color accentColor;
  final double minValue;
  final double maxValue;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 4.0;
    final trackLeft = offset.dx + 16;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 32;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    required TextDirection textDirection,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    if (!isEnabled) {
      return;
    }

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final radius = Radius.circular(PaceUiConstants.sliderTrackHeight);
    final inactiveColor = sliderTheme.inactiveTrackColor ?? Colors.grey;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, radius),
      Paint()..color = inactiveColor,
    );

    final fraction =
        ((thumbCenter.dx - trackRect.left) / trackRect.width).clamp(0.0, 1.0);
    final totalSeconds =
        (minValue + fraction * (maxValue - minValue)).round();
    final zone = resolveZone(totalSeconds);
    final (fillStartSec, fillEndSec) = fillRangeForZone(zone, totalSeconds);

    final fillStart = trackRect.left +
        trackRect.width * valueFraction(fillStartSec, minValue, maxValue);
    final fillEnd = trackRect.left +
        trackRect.width * valueFraction(fillEndSec, minValue, maxValue);

    if (fillEnd > fillStart) {
      final fillRect = Rect.fromLTRB(
        fillStart,
        trackRect.top,
        fillEnd,
        trackRect.bottom,
      );
      context.canvas.drawRRect(
        RRect.fromRectAndRadius(fillRect, radius),
        Paint()..color = accentColor,
      );
    }

    _paintTickMarks(context.canvas, trackRect, inactiveColor);
  }

  void _paintTickMarks(Canvas canvas, Rect trackRect, Color color) {
    final tickPaint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..strokeWidth = 1.5;

    for (final tick in PaceInputConstants.sliderTickSeconds) {
      final x = trackRect.left +
          trackRect.width * valueFraction(tick, minValue, maxValue);
      canvas.drawLine(
        Offset(x, trackRect.top - 4),
        Offset(x, trackRect.bottom + 4),
        tickPaint,
      );
    }
  }
}
