part of 'theme_bloc.dart';

class ThemeEvent extends Equatable{
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class CurrentThemeEvent extends ThemeEvent {
  final int currentThemeValue;
  const CurrentThemeEvent({required this.currentThemeValue});

  CurrentThemeEvent copyWith({int? currentThemeValue}) {
    return CurrentThemeEvent(
      currentThemeValue: currentThemeValue ?? this.currentThemeValue,
    );
  }

  @override
  List<Object?> get props => [currentThemeValue];
}