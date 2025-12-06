import 'package:flutter/material.dart';
import 'package:todolistapp/core/utils/dialog/all_dialogs/exit_dialog.dart';
import 'package:todolistapp/core/utils/dialog/common_dialog_widget.dart';
import 'all_dialogs/delete_dialog.dart';

class DialogHelper {
  static Future<bool> showYesNoDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const CommonDialogWidget(child: ExitDialog()),
        ) ??
        false;
  }

  static Future<bool> deletedEntryDialog({
    required BuildContext context,
    required VoidCallback onClick,
    String text = "transaction",
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => CommonDialogWidget(
            child: DeleteDialog(onClickYes: onClick, text: text),
          ),
    );
  }
}
