import 'package:flutter/material.dart';

import 'common_ui_fixes_demo.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_basics_demo.dart';
import 'scaffold_theme_demo.dart';

class Lab4App extends StatefulWidget {
  const Lab4App({super.key});

  @override
  State<Lab4App> createState() => _Lab4AppState();
}

class _Lab4AppState extends State<Lab4App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setDarkMode(bool enabled) {
    setState(() {
      _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Flutter UI Fundamentals',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF7FAF9),
        cardTheme: const CardThemeData(elevation: 1, margin: EdgeInsets.zero),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: Lab4HomeScreen(onDarkModeChanged: _setDarkMode),
    );
  }
}

class Lab4HomeScreen extends StatelessWidget {
  const Lab4HomeScreen({super.key, required this.onDarkModeChanged});

  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    final exercises = [
      _ExerciseLink(
        title: 'Exercise 1 - Core Widgets Demo',
        screen: const CoreWidgetsDemo(),
      ),
      _ExerciseLink(
        title: 'Exercise 2 - Input Controls Demo',
        screen: const InputControlsDemo(),
      ),
      _ExerciseLink(
        title: 'Exercise 3 - Layout Demo',
        screen: const LayoutBasicsDemo(),
      ),
      _ExerciseLink(
        title: 'Exercise 4 - App Structure & Theme',
        screen: ScaffoldThemeDemo(onDarkModeChanged: onDarkModeChanged),
      ),
      _ExerciseLink(
        title: 'Exercise 5 - Common UI Fixes',
        screen: const CommonUiFixesDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 - Flutter UI Fundamentals')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: exercises.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) => exercises[index],
        ),
      ),
    );
  }
}

class _ExerciseLink extends StatelessWidget {
  const _ExerciseLink({required this.title, required this.screen});

  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}
