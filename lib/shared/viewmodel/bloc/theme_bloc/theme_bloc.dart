import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/core/local/prefs_helper.dart';
import '../../../../core/constants/prefs_keys.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final PrefsHelper _prefs;

  ThemeBloc({
    required int initialTheme,
    required PrefsHelper prefs,
  })  : _prefs = prefs,
        super(ThemeState(currentTheme: initialTheme)) {
    on<CurrentThemeEvent>(_onCurrentThemeEvent);
  }

  Future<void> _onCurrentThemeEvent(
      CurrentThemeEvent event,
      Emitter<ThemeState> emit,
      ) async {
    await _prefs.setIntValue(PrefsKeys.currentTheme, event.currentThemeValue);
    emit(state.copyWith(currentTheme: event.currentThemeValue));
  }
}
