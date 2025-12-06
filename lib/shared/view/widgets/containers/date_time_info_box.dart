import 'package:flutter/material.dart';
import 'package:todolistapp/core/utils/util.dart';

class DateTimeInfoBox extends StatelessWidget {
  final String label;
  final String dateTime;
  final bool isClassic;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? insidePadding;
  final Color? textColor;
  final Color? bgColor;

  const DateTimeInfoBox({
    super.key,
    required this.label,
    required this.dateTime,
    this.isClassic = false,
    this.fontSize,
    this.fontWeight,
    this.insidePadding,
    this.bgColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =bgColor??Colors.white;
    final txtColor= textColor??Colors.black;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(insidePadding??6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        border: bgColor != null
            ? Border.all(
          color: txtColor,
          width: 1,
        )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: fontSize??11,
              fontWeight: fontWeight?? FontWeight.w700,
              color: txtColor,
            ),
          ),

          spacerH(5),

          isClassic
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date: ${dateTime.split('|')[0]}",
                style: TextStyle(
                  fontSize: fontSize??11,
                  fontWeight:fontWeight?? FontWeight.w700,
                  color: txtColor,
                ),
              ),
              spacerH(2),
              Text(
                "Time: ${dateTime.split('|')[1]}",
                style: TextStyle(
                  fontSize: fontSize??11,
                  fontWeight:fontWeight?? FontWeight.w700,
                  color: txtColor,
                ),
              ),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date: ${dateTime.split('|')[0]}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight:fontWeight?? FontWeight.w700,
                  color: txtColor,
                ),
              ),
              spacerH(2),
              Text(
                "Time: ${dateTime.split('|')[1]}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: fontWeight?? FontWeight.w700,
                  color: txtColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}