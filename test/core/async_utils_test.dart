import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/core/utils/async_utils.dart';

void main() {
  test('withMinDuration waits at least the minimum duration', () async {
    final stopwatch = Stopwatch()..start();
    await withMinDuration(
      Future.value(42),
      const Duration(milliseconds: 100),
    );
    stopwatch.stop();

    expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(100));
  });
}
