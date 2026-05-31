import 'package:flutter/material.dart';

enum MovieGenre { action, comedy, drama }

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _rating = 50;
  bool _isMovieActive = false;
  MovieGenre? _selectedGenre;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );

    if (!mounted || pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateText = _selectedDate == null
        ? 'None'
        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    final genreText = _selectedGenre == null ? 'None' : _selectedGenre!.label;

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 - Input Controls')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Rating (Slider)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              min: 0,
              max: 100,
              divisions: 20,
              label: _rating.round().toString(),
              value: _rating,
              onChanged: (value) {
                setState(() => _rating = value);
              },
            ),
            Text('Current value: ${_rating.round()}'),
            const SizedBox(height: 16),
            Text(
              'Active (Switch)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Is movie active?'),
              value: _isMovieActive,
              onChanged: (value) {
                setState(() => _isMovieActive = value);
              },
            ),
            const SizedBox(height: 12),
            Text(
              'Genre (RadioListTile)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // RadioGroup keeps the selected RadioListTile value in one parent.
            RadioGroup<MovieGenre>(
              groupValue: _selectedGenre,
              onChanged: _changeGenre,
              child: const Column(
                children: [
                  RadioListTile<MovieGenre>(
                    title: Text('Action'),
                    value: MovieGenre.action,
                  ),
                  RadioListTile<MovieGenre>(
                    title: Text('Comedy'),
                    value: MovieGenre.comedy,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text('Selected genre: $genreText'),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Open Date Picker'),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Updated values',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text('Rating: ${_rating.round()}'),
                    Text('Movie active: ${_isMovieActive ? 'Yes' : 'No'}'),
                    Text('Genre: $genreText'),
                    Text('Date: $selectedDateText'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeGenre(MovieGenre? genre) {
    setState(() {
      _selectedGenre = genre;
    });
  }
}

extension on MovieGenre {
  String get label {
    switch (this) {
      case MovieGenre.action:
        return 'Action';
      case MovieGenre.comedy:
        return 'Comedy';
      case MovieGenre.drama:
        return 'Drama';
    }
  }
}
