import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/util.dart';

class ReusableImageButton extends HookWidget {
  final Color? color;
  final VoidCallback onTap;
  final String url;
  final double? width;
  final double? height;

  const ReusableImageButton(
      {super.key,
        this.color,
        required this.onTap,
        required this.url,
       this.width=30,
       this.height});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return InkWell(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        onTap: onTap,
        child: staticImage(
            assetName: url, color: color ?? theme.onSurface, width: width?.w, height: height?.h));
  }
}