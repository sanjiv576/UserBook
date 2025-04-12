import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/data_source/remote/user_remote_data_source.dart';
import '../../domain/entity/user_entity.dart';

final allUsersProvider = StreamProvider.autoDispose<Iterable<UserEntity>>((
  ref,
) {
  final controller = StreamController<Iterable<UserEntity>>();

  Future<void> fetchUsers() async {
    try {
      final fetchedData = await UserRemoteDataSource.getAllUsers();
      fetchedData.fold(
        (left) {
          controller.addError(left.error);
        },
        (users) {
          controller.add(users);
        },
      );
      
    } catch (err) {
      log('Error while fetching: $err');
      controller.addError(err);
    }
  }

  fetchUsers();

  ref.onDispose(() {
    controller.close();
  });

  return controller.stream;
});
