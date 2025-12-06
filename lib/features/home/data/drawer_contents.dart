import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolistapp/core/constants/app_constants.dart';
import 'package:todolistapp/core/utils/dialog/dialog_helper.dart';
import '../../../core/routes/paths.dart';
import '../../../core/utils/util.dart';
import '../model/drawer_model.dart';
import 'package:share_plus/share_plus.dart';


List<DrawerModel> drawerContentsList(BuildContext context) => [
  DrawerModel(
    title: "App Tour",
    icon: FontAwesomeIcons.route,
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Paths.onBoardPage,
            (route) => false,
      );
      // your onboarding route
    },
  ),
  DrawerModel(
    title: "Share",
    icon: Icons.leaderboard,
    onTap: () async {
      Navigator.pop(context);
      await shareAppLink();
    },
  ),
  DrawerModel(
    title: "Mail",
    icon: Icons.mail,
    onTap: () {
      openUrl(
        url: "mailto:mysteriouscoderofficial@gmail.com?subject=Feedback",
        context: context,
        isExternal: true,
      );
      Navigator.pop(context);
    },
  ),
  DrawerModel(
    title: "Rate",
    icon: Icons.description_outlined,
    onTap: () async {
      Navigator.pop(context);
      await openUrl(url: 'https://play.google.com/store/apps/details?id=${AppConstants.appPackage}', context: context);
    },
  ),
  DrawerModel(
    title: "Privacy Policy",
    icon: Icons.privacy_tip,
    onTap: () {
      Navigator.pop(context);
      openUrl(
        isExternal: true,
        url: AppConstants.privacyPolicy,
        context: context,
      );
    },
  ),
  DrawerModel(
    title: "Exit",
    icon: Icons.logout,
    onTap: () async {
      Navigator.pop(context);
      await DialogHelper.showYesNoDialog(context);
    },
  ),
];


Future<void> shareAppLink() async {
  try {
    final String message =
        "Boost your productivity with a clean and powerful Notes App — organize tasks, set reminders, and stay on track effortlessly.\n\n"
        "Download now:\nhttps://play.google.com/store/apps/details?id=${AppConstants.appPackage}";

    await Share.share(message);
  } catch (e) {
    if (kDebugMode) {
      print('Error sharing app link: $e');
    }
  }
}
