import 'package:flutter_test/flutter_test.dart';

import 'package:test_task_swim_success/main.dart';

void main() {
  testWidgets('App renders with dark theme placeholder', (tester) async {
    await tester.pumpWidget(const SwimSuccessApp());

    expect(find.text('Swim Success'), findsOneWidget);
  });
}
