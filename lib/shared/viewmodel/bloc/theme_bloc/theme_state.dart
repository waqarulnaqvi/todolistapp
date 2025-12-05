
part of 'theme_bloc.dart';

class ThemeState extends Equatable{
  final int currentTheme;
  const ThemeState({this.currentTheme =0});
  ThemeState copyWith({int ? currentTheme}) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
    );
  }

  @override
  List<Object?> get props => [currentTheme];
}

