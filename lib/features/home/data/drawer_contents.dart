import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/util.dart';
import '../model/drawer_model.dart';

List<DrawerModel> drawerContentsList(BuildContext context) => [
      DrawerModel(
          title: "Connect",
          icon: Icons.person,
          onTap: () async {
            if (context.mounted) {
              Navigator.pop(context);
            }
            // await ReusableDialogClass.connectUsDialog(context);
          }),

      DrawerModel(
        title: "Share",
        icon: Icons.leaderboard,
        onTap: () async {
          if (context.mounted) {
            Navigator.pop(context);
          }
          await shareAppLink();
        },
      ),
      DrawerModel(
          title: "Mail",
          icon: Icons.mail,
          onTap: () {
            openUrl(
                url:
                    "mailto:mysteriouscoderofficial@gmail.com?subject=Feedback",
                context: context,
                isExternal: true);
            Navigator.pop(context);
          }),

      DrawerModel(
          title: "Privacy Policy",
          icon: Icons.privacy_tip,
          onTap: () {
            Navigator.pop(context);
            openUrl(
                url: 'https://mysteriouscoder.com/privacypolicy/',
                context: context);
          }),
      DrawerModel(
          title: "Exit",
          icon: Icons.logout,
          onTap: () async {
            if (context.mounted) {
              Navigator.pop(context);
            }
            // await ReusableDialogClass.showYesNoDialog(context);
          }),
    ];

Future<void> shareAppLink() async {
  try {
    // final String message =
    //     "Discover a powerful solution for managing your expenses and budget effectively:\n\n${Constants.noteMasterUrl}";
    // await Share.share(message);
  } catch (e) {
    if (kDebugMode) {
      print('Error sharing app link: $e');
    }
  }
}
