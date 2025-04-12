import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/all_users_provider.dart';
import '../widget/user_grid_view.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(allUsersProvider);
    return Scaffold(
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
