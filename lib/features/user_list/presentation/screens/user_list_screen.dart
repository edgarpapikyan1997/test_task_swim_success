import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exception.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../logic/user_list_cubit.dart';
import '../../logic/user_list_state.dart';
import '../widgets/user_list_status_body.dart';
import '../widgets/user_list_tile.dart';
import '../widgets/user_search_field.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserListCubit(UserRepositoryImpl()),
      child: const _UserListView(),
    );
  }
}

class _UserListView extends StatelessWidget {
  const _UserListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          return switch (state) {
            UserListLoading() => const UserListLoadingBody(),
            UserListError(:final message) => UserListErrorBody(
                message: message,
                onRetry: () => context.read<UserListCubit>().fetchUsers(),
              ),
            UserListLoaded() => _UserListLoadedBody(state: state),
          };
        },
      ),
    );
  }
}

class _UserListLoadedBody extends StatelessWidget {
  const _UserListLoadedBody({required this.state});

  final UserListLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserListCubit>();
    final visibleUsers = state.filteredUsers;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: UserSearchField(
            value: state.searchQuery,
            onChanged: cubit.updateSearchQuery,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _handleRefresh(context, cubit),
            child: visibleUsers.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 200),
                      UserListEmptyBody(),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: visibleUsers.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) => UserListTile(
                      user: visibleUsers[index],
                      onTap: () {},
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRefresh(BuildContext context, UserListCubit cubit) async {
    try {
      await cubit.refreshUsers();
    } on NetworkException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    }
  }
}
