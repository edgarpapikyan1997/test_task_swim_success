import 'package:flutter_test/flutter_test.dart';

import 'package:test_task_swim_success/main.dart';

void main() {
  testWidgets('Pace selector screen renders time input', (tester) async {
    await tester.pumpWidget(const SwimSuccessApp());

    expect(find.text('YOUR PACE'), findsOneWidget);
    expect(find.text('MIN : SEC / 100M'), findsOneWidget);
    expect(find.text('01'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('Advanced'), findsWidgets);
    expect(find.text('1:30'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
