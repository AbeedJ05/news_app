import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_app/providers/theme_notifier.dart';

class ChangeTheme extends ConsumerWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Change Theme")),
      body: Column(
        children: [
          _singleTile("Dark Theme", ThemeMode.dark, notifier),
          _singleTile("Light Theme", ThemeMode.light, notifier),
          _singleTile("System Theme", ThemeMode.system, notifier),
        ],
      ),
    );
  }

  Widget _singleTile(String title, ThemeMode mode, ThemeNotifier notifier) {
    return RadioListTile<ThemeMode>(
      value: mode,
      title: Text(title),
      groupValue: notifier.themeMode,
      onChanged: (val) {
        if (val != null) notifier.setTheme(val);
      },
    );
  }
}
