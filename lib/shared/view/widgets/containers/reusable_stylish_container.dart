import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';

class ReusableStylishContainer extends StatelessWidget {
  final double w;
  final double? h;
  final List<Color> colors;
  final String? title;
  final String description;
  final String image;
  final String buttonText;
  final bool isCarousel;
  final bool isShowHeading;
  final VoidCallback onTap;

  const ReusableStylishContainer(
      {super.key,
        required this.w,
        this.h,
        required this.colors,
        this.title,
        required this.description,
        required this.image,
        this.buttonText = "DOWNLOAD NOW",
        this.isCarousel = true,
        required this.onTap,
        this.isShowHeading = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isCarousel ? 445 : h,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none, // Allow overflow
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: isCarousel ? 445 : h,
                width: w,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spacerH(70),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isShowHeading)
                            Text(title ?? "",
                                style: AppStyles.headingPrimary(
                                    context: context, color: Colors.white),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis),
                          if (isShowHeading) spacerH(10),
                          Flexible(
                            child: Text(
                              description,
                              style: AppStyles.descriptionPrimary(
                                  context: context,
                                  color: Colors.white,
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              // maxLines: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    spacerH(),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: w,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onTap,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Text(buttonText,
                                  style: AppStyles.headingPrimary(
                                      context: context,
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // if(isCarousel)
                    // spacerH(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              // Adjust this value to give enough space for the CircleAvatar
              child: Material(
                elevation: 6, // shadow depth
                shape: const CircleBorder(),
                shadowColor: Colors.black45,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(image),
                ),
              )),
        ],
      ),
    );
  }
}
