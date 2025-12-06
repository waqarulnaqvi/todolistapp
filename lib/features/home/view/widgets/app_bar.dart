import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/static_assets/app_icons.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../shared/view/widgets/theme_controller_widget.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';

///AppBar
Widget appBar({
  required final ColorScheme theme,
  required final BuildContext context,
  required VoidCallback onPressed,
  required final GlobalKey<ScaffoldState> scaffoldKey,
}) {
  String timeString = DateTime.now().toString().split(" ")[1];
  // Parse the hour part
  int hour = int.parse(timeString.split(":")[0]);

  String greeting;
  if (hour >= 5 && hour < 12) {
    greeting = "Good Morning!";
  } else if (hour >= 12 && hour < 17) {
    greeting = "Good Afternoon!";
  } else {
    greeting = "Good Evening!";
  }
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 15),
    child: SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AppIcons.profileIcon),
          ),
          spacerW(10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi,",
                style: AppStyles.descriptionPrimary(
                  context: context,
                  fontSize: 14,
                  color: theme.surface,
                ),
              ),
              spacerH(2),
              Text(
                greeting,
                style: AppStyles.headingPrimary(
                  context: context,
                  fontSize: 16,
                  color: theme.surface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          spacerW(5),
          BlocSelector<HomeBloc, HomeState, bool>(
            selector: (state) => state.isShowSearchIcon,
            builder: (context, isShown) {
              return IconButton(
                onPressed: onPressed,
                icon: Icon(
                  isShown ? Icons.cancel : Icons.search_rounded,
                  color: theme.surface,
                ),
              );
            },
          ),

          ThemeControllerWidget(),
          InkWell(
            onTap: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            child:Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
            child: Icon(
              FontAwesomeIcons.barsStaggered,
              color: theme.surface,
              size: 20.r,
            ),
          ),),
        ],
      ),
    ),
  );
}
