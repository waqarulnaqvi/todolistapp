import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/util.dart';

class ReusableIconButton extends HookWidget {
  final String title;
  final IconData icon;
  final String url;
  final double spacerWidth;
  final double socialMediaIconFontSize;
  final double socialIconSize;
  final List<Color> colors;

  const ReusableIconButton(
      {super.key,
        required this.title,
        required this.icon,
        required this.colors,
        required this.url,
        this.spacerWidth = 10,
        this.socialMediaIconFontSize = 16,
        this.socialIconSize = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // changes position of shadow
          )
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            openUrl(url: url, context: context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: socialIconSize.r,
                ),
                SizedBox(
                  width: spacerWidth.w,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}