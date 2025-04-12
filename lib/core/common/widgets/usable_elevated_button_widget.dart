import 'package:flutter/material.dart';

class UsableElevatedButtonWidget extends StatelessWidget {
  const UsableElevatedButtonWidget({
    super.key,
    required this.onPress,
    required this.text,
    required this.iconData,
  });

  final VoidCallback onPress;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,

        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(iconData, color: Colors.white),
      label: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.white),
      ),
    );
  }
}
