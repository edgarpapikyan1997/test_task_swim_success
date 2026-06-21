import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_task_swim_success/features/user_list/data/models/address_model.dart';
import 'package:test_task_swim_success/features/user_list/data/models/company_model.dart';
import 'package:test_task_swim_success/features/user_list/data/models/user_model.dart';
import 'package:test_task_swim_success/features/user_list/presentation/screens/user_detail_screen.dart';

void main() {
  const user = UserModel(
    id: 1,
    name: 'Leanne Graham',
    username: 'Bret',
    email: 'Sincere@april.biz',
    phone: '1-770-736-8031 x56442',
    website: 'hildegard.org',
    address: AddressModel(
      street: 'Kulas Light',
      suite: 'Apt. 556',
      city: 'Gwenborough',
      zipcode: '92998-3874',
    ),
    company: CompanyModel(
      name: 'Romaguera-Crona',
      catchPhrase: 'Multi-layered client-server neural-net',
      bs: 'harness real-time e-markets',
    ),
  );

  testWidgets('User detail screen shows extended user fields', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: UserDetailScreen(user: user)),
    );

    expect(find.text('Leanne Graham'), findsOneWidget);
    expect(find.text('Sincere@april.biz'), findsOneWidget);
    expect(find.text('1-770-736-8031 x56442'), findsOneWidget);
    expect(find.text('hildegard.org'), findsOneWidget);
    expect(find.text('Kulas Light'), findsOneWidget);
    expect(find.text('Gwenborough'), findsOneWidget);
    expect(find.text('92998-3874'), findsOneWidget);
    expect(find.text('Romaguera-Crona'), findsOneWidget);
  });
}
