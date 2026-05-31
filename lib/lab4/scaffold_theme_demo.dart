import 'package:flutter/material.dart';

class ScaffoldThemeDemo extends StatefulWidget {
  const ScaffoldThemeDemo({super.key, required this.onDarkModeChanged});

  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<ScaffoldThemeDemo> createState() => _ScaffoldThemeDemoState();
}

class _ScaffoldThemeDemoState extends State<ScaffoldThemeDemo> {
  int _tapCount = 0;

  void _increaseTapCount() {
    setState(() {
      _tapCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 - App Structure'),
        actions: [
          const Text('Dark'),
          Switch(value: isDarkMode, onChanged: widget.onDarkModeChanged),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scaffold Screen',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text('ThemeData customization'),
                  subtitle: Text(
                    isDarkMode
                        ? 'Dark mode is enabled'
                        : 'Light mode is enabled',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.touch_app),
                  title: Text('FloatingActionButton taps: $_tapCount'),
                  subtitle: const Text('Tap the button to update screen state'),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 100),
                alignment: Alignment.bottomCenter,
                child: Text(
                  'This is a simple screen with the theme toggle.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _increaseTapCount,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
