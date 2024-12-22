import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  // Define your default thememode here
  ThemeMode themeMode = ThemeMode.light;
  SharedPreferences? prefs;

  ThemeNotifier() {
    _init();
  }

  _init() async {
    // Get the stored theme from shared preferences
    prefs = await SharedPreferences.getInstance();

    int theme = prefs?.getInt("theme") ?? themeMode.index;
    themeMode = ThemeMode.values[theme];
    notifyListeners();
  }

  setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
    // Save the selected theme using shared preferences
    prefs?.setInt("theme", mode.index);
  }
}

final themeNotifierProvider =
    ChangeNotifierProvider<ThemeNotifier>((_) => ThemeNotifier());