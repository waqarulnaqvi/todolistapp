import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todolistapp/shared/viewmodel/bloc/theme_bloc/theme_bloc.dart';
import 'package:todolistapp/core/local/prefs_helper.dart';
import 'package:todolistapp/core/constants/prefs_keys.dart';

// Mock class for PrefsHelper
class MockPrefsHelper extends Mock implements PrefsHelper {}

void main() {
  late MockPrefsHelper mockPrefs;

  setUp(() {
    mockPrefs = MockPrefsHelper();

    // Mock setIntValue to avoid real writes
    when(() => mockPrefs.setIntValue(any(), any()))
        .thenAnswer((_) async {});
  });

  // ---------------------------------------------------------------------------
  // TEST 1: Initial State
  // ---------------------------------------------------------------------------
  test('ThemeBloc initial state should contain the initial theme', () {
    final bloc = ThemeBloc(initialTheme: 0, prefs: mockPrefs);

    expect(bloc.state.currentTheme, 0);

    bloc.close();
  });

  // ---------------------------------------------------------------------------
  // TEST 2: Changing Theme Event
  // ---------------------------------------------------------------------------
  blocTest<ThemeBloc, ThemeState>(
    'emits updated theme when CurrentThemeEvent is added',
    build: () {
      return ThemeBloc(
        initialTheme: 0,
        prefs: mockPrefs,
      );
    },
    act: (bloc) => bloc.add(const CurrentThemeEvent(currentThemeValue: 1)),
    expect: () => [
      const ThemeState(currentTheme: 1),
    ],
    verify: (_) {
      verify(() => mockPrefs.setIntValue(PrefsKeys.currentTheme, 1)).called(1);
    },
  );
}
