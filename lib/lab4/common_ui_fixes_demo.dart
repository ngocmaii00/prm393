import 'package:flutter/material.dart';

class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo> {
  int _counter = 0;
  DateTime? _deadline;
  static const List<String> _movies = [
    'Movie A',
    'Movie B',
    'Movie C',
    'Movie D',
  ];

  Future<void> _selectDeadline() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    if (!mounted || picked == null) return;

    setState(() {
      _deadline = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deadlineText = _deadline == null
        ? 'No deadline selected'
        : '${_deadline!.day}/${_deadline!.month}/${_deadline!.year}';

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 - UI Fixes')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Correct ListView inside Column using Expanded',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'State update fix',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text('Counter: $_counter'),
                      const SizedBox(height: 8),
                      FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            // setState rebuilds the UI after the value changes.
                            _counter++;
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Increase'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.event_available),
                  title: Text(deadlineText),
                  subtitle: const Text('DatePicker uses this valid context'),
                  trailing: IconButton(
                    onPressed: _selectDeadline,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Expanded gives the ListView remaining height and prevents layout errors.
              Expanded(
                child: ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.movie),
                      title: Text(_movies[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
