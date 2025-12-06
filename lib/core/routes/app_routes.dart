import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/core/routes/paths.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import 'package:todolistapp/features/home/view/pages/home_page.dart';
import '../../features/home/view/pages/notes_management_page.dart';
import '../../features/home/viewmodel/bloc/home_bloc/home_bloc.dart';
import '../../features/onboard/view/pages/on_boarding_page.dart';
import '../../features/splash/view/pages/splash_page.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Paths.initial:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case Paths.homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),  // ← USE GLOBAL BLOC
        );

      case Paths.onBoardPage:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),  // ← USE GLOBAL BLOC
        );

      case Paths.notesManagementPage:
        final myNotesModel = settings.arguments as TodoListModel?;

        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<HomeBloc>(context), // SAME INSTANCE
            child: NotesManagementPage(myNotesModel: myNotesModel),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}

