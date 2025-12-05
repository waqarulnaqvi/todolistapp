import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/core/constants/app_constants.dart';
import 'package:todolistapp/core/constants/prefs_keys.dart';
import 'package:todolistapp/core/local/prefs_helper.dart';
import 'package:todolistapp/shared/utils/theme_value.dart';
import 'package:todolistapp/shared/viewmodel/bloc/theme_bloc/theme_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/paths.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator (DI)
  await initializeDependencies();

  // // Initialize HiveHelper singleton
  final prefs = sL<PrefsHelper>();
  //
  // // Get saved theme value safely
  final savedTheme = await prefs.getIntValue(PrefsKeys.currentTheme) ?? 0;

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    BlocProvider(
      create: (_) => ThemeBloc(initialTheme: savedTheme, prefs: prefs),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme();

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        ///Assuming that the ThemeState is 0 as LightTheme and 1 as DarkTheme.
        return ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: theme.light(),
            darkTheme: theme.dark(),

            themeMode: state.currentTheme == ThemeValue.light.value
                ? ThemeMode.light
                : ThemeMode.dark,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: Paths.initial,
          ),
        );
      },
    );
  }
}
