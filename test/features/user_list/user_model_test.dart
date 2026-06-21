import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/features/user_list/data/models/user_model.dart';

void main() {
  group('UserModel.fromJson', () {
    const sampleJson = {
      'id': 1,
      'name': 'Leanne Graham',
      'username': 'Bret',
      'email': 'Sincere@april.biz',
      'address': {
        'street': 'Kulas Light',
        'suite': 'Apt. 556',
        'city': 'Gwenborough',
        'zipcode': '92998-3874',
        'geo': {'lat': '-37.3159', 'lng': '81.8996'},
      },
      'phone': '1-770-736-8031 x56442',
      'website': 'hildegard.org',
      'company': {
        'name': 'Romaguera-Crona',
        'catchPhrase': 'Multi-layered client-server neural-net',
        'bs': 'harness real-time e-markets',
      },
    };

    test('parses all fields', () {
      final user = UserModel.fromJson(sampleJson);

      expect(user.id, 1);
      expect(user.name, 'Leanne Graham');
      expect(user.email, 'Sincere@april.biz');
      expect(user.phone, '1-770-736-8031 x56442');
      expect(user.website, 'hildegard.org');
      expect(user.address.street, 'Kulas Light');
      expect(user.address.city, 'Gwenborough');
      expect(user.company.name, 'Romaguera-Crona');
    });
  });
}
