// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:enr_tickets/core/utils/local_storage.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()) {
    _loadSettings();
  }

  bool isThemeOpen = false;
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = const Locale('en');

  void _loadSettings() async {
    themeMode = await LocalStorage.getThemeMode();
    locale = Locale(await LocalStorage.getLanguage());
    emit(SettingsChange());
  }

  void toggleTheme() {
    isThemeOpen = !isThemeOpen;
    emit(SettingsChange());
  }

  void changeTheme(ThemeMode mode) async {
    themeMode = mode;
    await LocalStorage.saveThemeMode(mode); // حفظ
    emit(SettingsChange());
  }

  String get themeText {
    switch (themeMode) {
      case ThemeMode.system:
        return "Follow System";
      case ThemeMode.light:
        return "Light Mode";
      case ThemeMode.dark:
        return "Dark Mode";
    }
  }

  void changeLanguage(String langCode) async {
    locale = Locale(langCode);
    await LocalStorage.saveLanguage(langCode); // حفظ
    emit(SettingsChange());
  }

  Future<void> logout() async {
    // مسح أي بيانات مستخدم محلية
    await LocalStorage.logout(); // دالة افتراضية امسح فيها بيانات المستخدم

    // إرسال الحالة للـ UI
    emit(SettingsLogout());
  }
}
