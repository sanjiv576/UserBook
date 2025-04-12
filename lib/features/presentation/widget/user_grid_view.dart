
import 'package:flutter/material.dart';
import '../../domain/entity/user_entity.dart';
import 'user_thumbnail_view.dart';

class UserGridView extends StatelessWidget {
  const UserGridView({super.key, required this.users});

  final Iterable<UserEntity> users;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: users.length,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      itemBuilder: (context, index) {
        final singleUser = users.elementAt(index);

        return UserThumbnailView(singleUser: singleUser);
      },
    );
  }
}
