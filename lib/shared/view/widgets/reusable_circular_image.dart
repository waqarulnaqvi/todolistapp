import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todolistapp/core/constants/static_assets/app_icons.dart';

class ReusableCircularImage extends HookWidget {
  final double width;
  final double height;
  final String? image;
  final double borderWidth;
  final Color? borderColor;
  final BoxFit fit;
  const ReusableCircularImage({super.key, this.width=50,this.height=50, this.image, this.borderWidth=0.5, this.borderColor , this.fit=BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(image??AppIcons.appIcon),
          fit: fit,
        ),
        border: Border.all(color: borderColor??theme.onSurface, width: borderWidth),
      ),
    );
  }
}
