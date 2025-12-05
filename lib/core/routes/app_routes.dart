import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/core/routes/paths.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import 'package:todolistapp/features/home/view/pages/home_page.dart';

import '../../features/home/view/pages/notes_management_page.dart';
import '../../features/home/viewmodel/bloc/home_bloc/home_bloc.dart';
import '../../features/splash/view/pages/splash_page.dart';
import '../di/service_locator.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Paths.initial:
        return MaterialPageRoute(builder: (context) => SplashPage());

      case Paths.homePage:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(create: (_) => sL<HomeBloc>(), child: HomePage()),
        );

      case Paths.notesManagementPage:
        final myNotesModel = settings.arguments as TodoListModel?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: sL<HomeBloc>(), // use existing HomeBloc instance
            child: NotesManagementPage(myNotesModel: myNotesModel),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
