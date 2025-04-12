import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: AppView()));
}
