abstract final class PaceInputConstants {
  static const int maxMinutes = 4;
  static const int minMinutes = 0;
  static const int maxSeconds = 59;
  static const int minSeconds = 0;

  static const int minTotalSeconds = 30;
  static const int maxTotalSeconds = 240;

  static const int defaultMinutes = 1;
  static const int defaultSeconds = 30;

  /// Reference labels on the slider (1:10, 1:30, 2:00).
  static const List<int> sliderTickSeconds = [70, 90, 120];

  /// Visual zone boundaries for slider fill — intermediate extends to 3:00 so
  /// beginner does not dominate the track; ticks remain reference labels only.
  static const List<int> sliderZoneBoundarySeconds = [70, 90, 180];
}
