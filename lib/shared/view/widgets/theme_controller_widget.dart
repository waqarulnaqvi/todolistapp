import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/constants/static_assets/app_icons.dart';
import '../../viewmodel/bloc/theme_bloc/theme_bloc.dart';

class ThemeControllerWidget extends HookWidget {
  const ThemeControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<ThemeBloc>().add(
              CurrentThemeEvent(
                currentThemeValue: state.currentTheme == 0 ? 1 : 0,
              ),
            );
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(10.0),
            shape: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Image(
                image: AssetImage(
                  state.currentTheme ==0
                      ? AppIcons.darkThemeIcon
                      : AppIcons.lightThemeIcon,
                ),
                width: 23,
                height: 23,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}
