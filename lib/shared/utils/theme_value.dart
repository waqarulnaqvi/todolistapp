
enum ThemeValue {
  light,
  dark;

  int get value{
    switch (this) {
      case ThemeValue.light:
        return 0;
      case ThemeValue.dark:
        return 1;
    }
  }
}

// This enum represents the possible theme values for the application.
// It can be used to toggle between light and dark themes in the app.

