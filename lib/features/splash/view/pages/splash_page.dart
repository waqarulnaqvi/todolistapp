import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:todolistapp/core/constants/static_assets/app_animation.dart';
import 'package:todolistapp/core/constants/static_assets/app_icons.dart';
import 'package:todolistapp/core/routes/paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/util.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color:AppColors.themeLight , width: 1),
                ),
                child: Lottie.asset(
                  AppAnimation.splashPageLottie,
                  controller: animationController,
                  onLoaded: (composition) {
                    animationController
                      ..duration = composition.duration
                      ..forward().whenComplete(() {
                        // Navigate to the next page after the animation completes
                        Navigator.pushReplacementNamed(
                          context,
                          Paths.homePage,
                        );
                      });
                  },
                ),
              ),
            ),
            Spacer(),
            staticImage(
              height: 100,
              assetName: AppIcons.brandIcon,
            ),
            spacerH(),
          ],
        ),
      ),
    );
  }
}
