import 'package:flutter/material.dart';
import 'package:todolistapp/core/theme/app_styles.dart';

Widget reusableRadioButton({
  required final double w,
  required final e,
  required final filter,
  required ValueChanged<String> onChanged,
  required BuildContext context,
}) {
  return Flexible(
    child: RadioListTile(
      value: e.value,
      title: Text(
        e.value,
        style: AppStyles.descriptionPrimary(context: context, fontSize: 14),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      groupValue: filter,
      contentPadding: EdgeInsets.zero,
      // Removes extra padding
      visualDensity: VisualDensity(horizontal: -4.0),
      // Tighten horizontal space
      controlAffinity: ListTileControlAffinity.leading,
      // Radio on the left
      onChanged: (value) => onChanged(value!),
    ),
  );
}