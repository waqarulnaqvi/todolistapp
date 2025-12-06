import 'package:flutter/material.dart';
import 'package:todolistapp/core/utils/dialog/dialog_helper.dart';
import '../../../core/utils/util.dart';
import '../model/drawer_model.dart';

List<DrawerModel> drawerContentsList(BuildContext context) => [
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
    title: "Privacy Policy",
    icon: Icons.privacy_tip,
    onTap: () {
      Navigator.pop(context);
      openUrl(
        isExternal: true,
        url: 'https://mysteriouscoder.com/',
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
