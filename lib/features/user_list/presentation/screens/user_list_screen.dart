import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_exception.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_background.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../logic/user_list_cubit.dart';
import '../../logic/user_list_state.dart';
import '../screens/user_detail_screen.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Users')),
      body: AppBackground(
        child: BlocBuilder<UserListCubit, UserListState>(
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
      ),
    );
  }
}

class _UserListLoadedBody extends StatefulWidget {
  const _UserListLoadedBody({required this.state});

  final UserListLoaded state;

  @override
  State<_UserListLoadedBody> createState() => _UserListLoadedBodyState();
}

class _UserListLoadedBodyState extends State<_UserListLoadedBody> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserListCubit>();
    final visibleUsers = widget.state.filteredUsers;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: UserSearchField(
            value: widget.state.searchQuery,
            onChanged: cubit.updateSearchQuery,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _handleRefresh(cubit),
            child: visibleUsers.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: AppSizes.emptyStateSpacerHeight),
                      UserListEmptyBody(),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: visibleUsers.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final user = visibleUsers[index];
                      return UserListTile(
                        user: user,
                        onTap: () => _openUserDetail(user),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRefresh(UserListCubit cubit) async {
    try {
      await cubit.refreshUsers();
    } on NetworkException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    }
  }

  Future<void> _openUserDetail(UserModel user) async {
    if (_isNavigating) {
      return;
    }
    setState(() => _isNavigating = true);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => UserDetailScreen(user: user),
      ),
    );
    if (mounted) {
      setState(() => _isNavigating = false);
    }
  }
}
