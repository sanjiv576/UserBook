import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/common/widgets/usable_elevated_button_widget.dart';
import '../providers/user_provider_state.dart';
import 'home_view.dart';
import 'update_profile_view.dart';
import '../widget/profile_section_view.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key, required this.userId});
  final int userId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => ref.read(userProvider.notifier).getUserById(widget.userId),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Account'),
              content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final userState = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text('User Profile'), centerTitle: true),

      body: SafeArea(
        child: Column(
          children: [
            if (userState.isLoading) ...{
              Center(child: CircularProgressIndicator()),
            },
            if (userState.error != null) ...{
              Center(child: Text('${userState.error}')),
            },
            if (userState.user != null) ...{
              ProfileSectionView(user: userState.user!, theme: theme),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    UsableElevatedButtonWidget(
                      iconData: Icons.edit,
                      text: "Update Profile",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    UpdateProfileView(user: userState.user!),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    UsableElevatedButtonWidget(
                      iconData: Icons.delete_forever,
                      text: "Delete Account",
                      onPress: () async {
                        final shouldDelete = await _showDeleteConfirmation(
                          context,
                        );

                        if (!shouldDelete) return;

                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          const SnackBar(
                            content: Text('Deleting account...'),
                            duration: Duration(seconds: 4),
                          ),
                        );

                        final result = await ref
                            .read(userProvider.notifier)
                            .deleteUserById(userId: widget.userId);
                        scaffold.hideCurrentSnackBar();

                        result.fold(
                          (failure) {
                            scaffold.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Deletion failed: ${failure.error}',
                                ),
                              ),
                            );
                          },
                          (success) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => HomeView()),
                              (route) => false,
                            );
                            scaffold.showSnackBar(
                              const SnackBar(
                                content: Text('Account deleted successfully'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
