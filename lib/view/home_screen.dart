import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:usersbook/utils/remote_data_source.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    fetchAllUsers();
    super.initState();
  }

  void fetchAllUsers() async {
    await RemoteDataSource.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('D')));
  }
}
