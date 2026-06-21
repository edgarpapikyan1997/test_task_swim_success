import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_swim_success/features/user_list/data/models/address_model.dart';
import 'package:test_task_swim_success/features/user_list/data/models/company_model.dart';
import 'package:test_task_swim_success/features/user_list/data/models/user_model.dart';
import 'package:test_task_swim_success/features/user_list/logic/user_list_state.dart';

void main() {
  group('UserListLoaded.filteredUsers', () {
    const users = [
      UserModel(
        id: 1,
        name: 'Alice Smith',
        username: 'alice',
        email: 'alice@test.com',
        phone: '111',
        website: 'alice.com',
        address: AddressModel(
          street: 'A',
          suite: '1',
          city: 'City',
          zipcode: '00000',
        ),
        company: CompanyModel(name: 'Co', catchPhrase: 'p', bs: 'b'),
      ),
      UserModel(
        id: 2,
        name: 'Bob Jones',
        username: 'bob',
        email: 'bob@test.com',
        phone: '222',
        website: 'bob.com',
        address: AddressModel(
          street: 'B',
          suite: '2',
          city: 'Town',
          zipcode: '11111',
        ),
        company: CompanyModel(name: 'Inc', catchPhrase: 'p', bs: 'b'),
      ),
    ];

    test('returns all users when query is empty', () {
      const state = UserListLoaded(users: users);
      expect(state.filteredUsers.length, 2);
    });

    test('filters by name case-insensitively', () {
      const state = UserListLoaded(users: users, searchQuery: 'alice');
      expect(state.filteredUsers, [users.first]);
    });
  });
}
