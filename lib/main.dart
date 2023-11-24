import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  var box = await Hive.openBox('auth');
  Auth.accessToken = box.get('access_token');
  Auth.isPrimary = box.get('is_primary')??false;
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
