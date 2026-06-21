import '../constants/app_durations.dart';

Future<T> withMinDuration<T>(Future<T> future, Duration minDuration) async {
  final results = await Future.wait<dynamic>([
    future,
    Future<void>.delayed(minDuration),
  ]);
  return results.first as T;
}

Future<T> withMinLoadingDisplay<T>(Future<T> future) =>
    withMinDuration(future, AppDurations.minLoadingDisplay);
