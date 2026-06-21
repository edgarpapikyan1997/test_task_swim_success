import 'package:equatable/equatable.dart';

import '../data/models/user_model.dart';

sealed class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object?> get props => [];
}

final class UserListLoading extends UserListState {
  const UserListLoading();
}

final class UserListLoaded extends UserListState {
  const UserListLoaded({
    required this.users,
    this.searchQuery = '',
  });

  final List<UserModel> users;
  final String searchQuery;

  List<UserModel> get filteredUsers {
    if (searchQuery.trim().isEmpty) {
      return users;
    }
    final query = searchQuery.trim().toLowerCase();
    return users
        .where((user) => user.name.toLowerCase().contains(query))
        .toList();
  }

  UserListLoaded copyWith({
    List<UserModel>? users,
    String? searchQuery,
  }) {
    return UserListLoaded(
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [users, searchQuery];
}

final class UserListError extends UserListState {
  const UserListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
