import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/all_users_provider.dart';
import '../widget/user_grid_view.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(allUsersProvider);
    return Scaffold(
      appBar: AppBar(title: Text('All Users'), centerTitle: true),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: users.when(
          data: (user) {
            if (user.isEmpty) {
              return Center(child: Text('Empty'));
            }

            return UserGridView(users: user);
          },
          error: (error, errorStack) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
