import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/common/widgets/usable_elevated_button_widget.dart';
import '../../../core/common/widgets/usable_textform_field.dart';
import '../../domain/entity/user_entity.dart';
import '../providers/user_provider_state.dart';

class UpdateProfileView extends ConsumerStatefulWidget {
  const UpdateProfileView({super.key, required this.user});
  final UserEntity user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateProfileViewState();
}

class _UpdateProfileViewState extends ConsumerState<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserEntity(
        id: widget.user.id,
        avatar: widget.user.avatar,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
      );

      ref.read(userProvider.notifier).updateUserById(updatedUser: updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully! 🎉")),
      );

      Navigator.popAndPushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.user.avatar),
              ),
              const SizedBox(height: 16),

              UsableTextFormField(
                controller: _firstNameController,
                label: "First Name",
                validator:
                    (value) => value!.isEmpty ? "First name is required" : null,
              ),
              UsableTextFormField(
                controller: _lastNameController,
                label: "Last Name",
                validator:
                    (value) => value!.isEmpty ? "Last name is required" : null,
              ),
              UsableTextFormField(
                controller: _emailController,
                label: "Email Address",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
                    r"[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              UsableElevatedButtonWidget(
                iconData: Icons.edit,
                text: "Update Profile",
                onPress: _updateProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
