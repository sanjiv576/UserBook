import 'dart:developer';

import 'package:flutter/material.dart';
import '../../domain/entity/user_entity.dart';

class UserThumbnailView extends StatelessWidget {
  const UserThumbnailView({super.key, required this.singleUser});

  final UserEntity singleUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('Tapped: ${singleUser.id}');
      },
      child: Column(
        spacing: 12,
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(singleUser.avatar),
            ),
          ),

          Text('${singleUser.firstName} ${singleUser.lastName}'),
        ],
      ),
    );
  }
}
