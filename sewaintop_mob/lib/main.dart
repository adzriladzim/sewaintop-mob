import 'package:flutter/material.dart';
import 'package:sewaintop_mob/views/main_navigation.dart'; // Import the unified navigation shell

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SewaIn Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const MainNavigationScaffold(), // Use MainNavigationScaffold
    );
  }
}
