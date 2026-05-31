# Lab 4 - Flutter UI Fundamentals

This Flutter project now opens the Lab 4 demo from `lib/main.dart`.

## Source Code

- `lib/lab4/lab4_app.dart`: main Lab 4 app, navigation menu, ThemeData, ThemeMode.
- `lib/lab4/core_widgets_demo.dart`: Exercise 1 - Text, Image, Icon, Card, ListTile.
- `lib/lab4/input_controls_demo.dart`: Exercise 2 - Slider, Switch, RadioListTile, DatePicker.
- `lib/lab4/layout_basics_demo.dart`: Exercise 3 - Column, Row, Padding, ListView.builder.
- `lib/lab4/scaffold_theme_demo.dart`: Exercise 4 - Scaffold, AppBar, FAB, ThemeData, Dark Mode toggle.
- `lib/lab4/common_ui_fixes_demo.dart`: Exercise 5 - fixed common UI issues.

## How To Run

1. Install Flutter SDK and open this folder in Android Studio or VS Code.
2. Get dependencies:

```bash
flutter pub get
```

3. Run on an emulator, device, Chrome, or Edge:

```bash
flutter run
```

4. Optional checks:

```bash
dart format lib/main.dart lib/lab4 test/widget_test.dart
flutter analyze
flutter test
```

## Exercise 5 Fix Explanation

- ListView inside Column: wrapped with `Expanded` so the list gets a bounded height.
- Overflow on small screens: wrapped wide horizontal content with `SingleChildScrollView`.
- State update issue: changed values inside `setState()` so Flutter rebuilds the UI.
- DatePicker context issue: called `showDatePicker()` from a valid `State` context in the widget tree.

## Screenshots

Run the app and open each exercise from the Lab 4 home screen. Save screenshots for:

- Exercise 1 - Core Widgets
- Exercise 2 - Input Widgets
- Exercise 3 - Layout Basics
- Exercise 4 - Scaffold and Theme
- Exercise 5 - UI Fixes
