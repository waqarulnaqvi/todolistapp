import 'package:get_it/get_it.dart';
import 'package:todolistapp/core/local/db_helper.dart';
import '../../features/home/viewmodel/bloc/home_bloc/home_bloc.dart';
import '../local/prefs_helper.dart';

final sL = GetIt.instance;

Future<void> initializeDependencies() async {
  /// 🔹 SQF lite singleton
  sL.registerLazySingleton<DBHelper>(() => DBHelper());

  /// 🔹 PrefsHelper singleton
  sL.registerSingleton<PrefsHelper>(PrefsHelper());

  // 🔹 HomeBloc factory
  sL.registerFactory<HomeBloc>(() => HomeBloc());
}
