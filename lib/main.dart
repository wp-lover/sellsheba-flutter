import 'package:flutter/material.dart';
import 'core/config/app_theme.dart';
import 'features/branch_management/presentation/pages/branch_selection_page.dart'; // Placeholder

void main() {
  runApp(const SellShebaConnectApp());
}

class SellShebaConnectApp extends StatelessWidget {
  const SellShebaConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SellSheba Connect',
      debugShowCheckedModeBanner: false,

      // Theme settings with Dark Mode support
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system, // Starts by respecting system preference
      // Start the app on the Login screen (or a splash screen)
      home:
          const BranchSelectionPage(), // TEMP: Placeholder. We will start with Auth flow later.
    );
  }
}
