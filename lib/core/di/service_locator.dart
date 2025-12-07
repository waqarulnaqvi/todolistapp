import 'package:get_it/get_it.dart';
import 'package:todolistapp/core/local/db_helper.dart';
import 'package:todolistapp/core/services/notification_helper.dart';
import '../../features/home/viewmodel/bloc/home_bloc/home_bloc.dart';
import '../../shared/viewmodel/bloc/theme_bloc/theme_bloc.dart';
import '../constants/prefs_keys.dart';
import '../local/prefs_helper.dart';

final sL = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  sL.registerLazySingleton<PrefsHelper>(() => PrefsHelper());
  sL.registerLazySingleton<DBHelper>(() => DBHelper());
  sL.registerLazySingleton<NotificationHelper>(() => NotificationHelper());

  // Load theme from prefs
  final prefs = sL<PrefsHelper>();
  final savedTheme = await prefs.getIntValue(PrefsKeys.currentTheme) ?? 0;

  // Register ThemeBloc as singleton
  sL.registerLazySingleton<ThemeBloc>(
        () => ThemeBloc(initialTheme: savedTheme, prefs: prefs),
  );

  // HomeBloc → Factory (each Flow/Screen Group receives its own instance)
  sL.registerFactory<HomeBloc>(
        () => HomeBloc(
      dbHelper: sL<DBHelper>(),
    ),
  );
}
