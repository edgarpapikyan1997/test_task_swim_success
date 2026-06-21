import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exception.dart';
import '../data/repository/user_repository.dart';
import 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit(this._repository) : super(const UserListLoading()) {
    fetchUsers();
  }

  final UserRepository _repository;

  Future<void> fetchUsers() => _loadUsers(isRefresh: false);

  Future<void> refreshUsers() => _loadUsers(isRefresh: true);

  void updateSearchQuery(String query) {
    final current = state;
    if (current is UserListLoaded) {
      emit(current.copyWith(searchQuery: query));
    }
  }

  Future<void> _loadUsers({required bool isRefresh}) async {
    final loadedState = state is UserListLoaded ? state as UserListLoaded : null;
    final preservedQuery = loadedState?.searchQuery ?? '';

    if (!isRefresh || loadedState == null) {
      emit(const UserListLoading());
    }

    try {
      final users = await _repository.getUsers();
      emit(UserListLoaded(users: users, searchQuery: preservedQuery));
    } on NetworkException catch (error) {
      if (isRefresh && loadedState != null) {
        emit(loadedState);
        rethrow;
      }
      emit(UserListError(error.message));
    } catch (_) {
      const message = 'Something went wrong. Please try again.';
      if (isRefresh && loadedState != null) {
        emit(loadedState);
        throw const NetworkServerException(message);
      }
      emit(const UserListError(message));
    }
  }
}
