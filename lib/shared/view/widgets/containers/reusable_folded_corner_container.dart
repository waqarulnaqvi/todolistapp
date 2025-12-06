import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolistapp/core/theme/app_colors.dart';
import 'package:todolistapp/core/utils/dialog/dialog_helper.dart';
import 'package:todolistapp/features/home/viewmodel/bloc/home_bloc/home_bloc.dart';
import 'package:todolistapp/shared/view/widgets/containers/date_time_info_box.dart';
import 'package:todolistapp/shared/view/widgets/containers/reusable_folded_corner_container.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../painter/folded_corner_painter.dart';

class ReusableFoldedCornerContainer extends StatelessWidget {
  final String title;
  final String description;
  final String creationDate;
  final String dueDate;
  final Color priorityColor;
  final bool specialHeight;
  final VoidCallback? onTap;
  final bool hideDecoration;
  final double? height;
  final int id;
  final bool isReminder;

  const ReusableFoldedCornerContainer({
    super.key,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.dueDate,
    required this.priorityColor,
    required this.id,
    required this.isReminder,
    this.height,
    this.specialHeight = false,
    this.hideDecoration = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final designColor = Colors.black;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          if (!hideDecoration) ...[
            Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: priorityColor,
                shape: BoxShape.circle,
                border: Border.all(color: designColor, width: 3.0),
              ),
            ),
            SizedBox(
              width: 8,
              child: Divider(
                thickness: 2, // Set the thickness of the line
                color: designColor, // Set the color of the line
              ),
            ),
          ],
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: CustomPaint(
                painter: FoldedCornerPainter(color: priorityColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppStyles.headingPrimary(
                              context: context,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            maxLines: specialHeight ? 2 : 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          spacerH(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  description,
                                  style: AppStyles.descriptionPrimary(
                                    context: context,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  maxLines: specialHeight ? 3 : 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              spacerW(10),
                              InkWell(
                                onTap: () {
                                  DialogHelper.deletedEntryDialog(
                                    context: context,
                                    onClick: () {
                                      context.read<HomeBloc>().add(
                                        DeleteNoteEvent(key: id),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    text: "entry",
                                  );
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                  size: 25.r,
                                ),
                              ),
                            ],
                          ),

                          if (hideDecoration) Spacer(),

                          spacerH(10),

                          DateTimeInfoBox(
                            fontSize: hideDecoration==false? 14 :null,
                            fontWeight: FontWeight.w500,
                            label: "Creation Date/Time",
                            dateTime: creationDate,
                            isClassic: !hideDecoration,
                          ),

                          spacerH(10),

                          DateTimeInfoBox(
                            fontSize: hideDecoration==false? 14 :null,
                            fontWeight: FontWeight.w500,
                            label: "Due Date/Time",
                            dateTime: dueDate,
                            isClassic: !hideDecoration,
                          ),
                        ],
                      ),
                    ),
                    if(isReminder)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        color: AppColors.themeLight
                      ),
                      padding: EdgeInsets.all(5.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bookmark,color: Colors.white,),
                        spacerW(10),
                        Text("Reminder Added",
                        style: AppStyles.headingPrimary(context: context,color: Colors.white,fontSize: 18),),
                      ],
                    ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (!hideDecoration)
            SizedBox(
              width: 35,
              child: Divider(
                thickness: 2, // Set the thickness of the line
                color: designColor, // Set the color of the line
              ),
            ),
        ],
      ),
    );
  }
}


