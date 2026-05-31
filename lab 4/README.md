# Lab 4 Submission Notes

The runnable Flutter source code is in `lib/lab4/` because Dart import paths should not contain spaces.

Files included:

- `core_widgets_demo.dart`
- `input_controls_demo.dart`
- `layout_basics_demo.dart`
- `scaffold_theme_demo.dart`
- `common_ui_fixes_demo.dart`
- `lab4_app.dart`

Run from the project root:

```bash
flutter pub get
flutter run
```

Exercise 5 fixes:

- `Expanded` fixes `ListView` inside `Column`.
- `SingleChildScrollView` fixes overflow on small screens.
- `setState()` fixes state updates that do not appear on screen.
- `showDatePicker()` is called from a valid widget tree context.
