import 'package:flutter/material.dart';
import '../../domain/entity/user_entity.dart';

class ProfileSectionView extends StatelessWidget {
  const ProfileSectionView({
    super.key,
    required this.user,
    required this.theme,
  });

  final UserEntity user;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.avatar),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${user.firstName} ${user.lastName}',
            style: theme.textTheme.headlineLarge!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
