import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> categories;
  final String selectedValue;
  final IconData icon;
  final void Function(String?)? onChanged;
  final Color color;
  final IconData? leadingIcon;
  final double? leadingIconSize;
  final Color? borderColor;
  final VoidCallback? onTap;

  const CustomDropDown(
      {super.key,
        required this.categories,
        required this.onChanged,
        required this.icon,
        required this.selectedValue,
        this.color=Colors.white,
        this.leadingIcon,
        this.leadingIconSize,
        this.borderColor,
        this.onTap
      });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
            height: 45.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color:borderColor ??color,
                ),
                color: theme.surface,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      spacerW(5),
                      Icon(
                        leadingIcon ,
                        color: color,
                        size: leadingIconSize,
                      ),
                      spacerW(10),
                      Flexible(
                        child: Text(selectedValue,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.descriptionPrimary(
                                context: context, color: color)),
                      ),
                      spacerW(10),
                    ],
                  ),
                ),

                Icon(
                  icon,
                )
              ],
            )),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: theme.primary, width: .5),
              color: theme.surface),
        ),
        onMenuStateChange: (isOpen){
          if(onTap!=null) {
            onTap!();
          }
        },
        items: categories
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  height: 0,
                  color: theme.onSurface,
                  letterSpacing: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}