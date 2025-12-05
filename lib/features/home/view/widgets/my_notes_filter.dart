import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../../utils/notes_filters.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';

class MyNotesFilter extends HookWidget {
  const MyNotesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final homeBloc = context.read<HomeBloc>();


    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: AppStyles.headingPrimary(
                    context: context,
                    color: Colors.black,
                  ),
                ),
                spacerW(15),
                InkWell(
                  onTap: () {
                    homeBloc.add(HomeToggleFilterEvent());
                  },
                  //Method 1:
                  // child:Transform.rotate(
                  //   angle: isSelected? 3.1416 :0, // 180 degrees in radians
                  //   child: Icon(Icons.filter_list),
                  // )
                  //Method 2:
                  child: AnimatedRotation(
                    turns: state.isShowFilter ? 0.5 : 0.0,
                    // 0.5 = 180 degrees
                    duration: Duration(milliseconds: 300),
                    child: Icon(Icons.filter_list, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          if (state.isShowFilter)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
              child:
                  // DottedBorder(
                  //   color: Theme.of(context).colorScheme.surface,
                  //   strokeWidth: 1,
                  //   borderType: BorderType.RRect,
                  //   radius: Radius.circular(15),
                  //   dashPattern: [5, 5],
                  //   child:
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: SortingFilter.values.map((e) {
                              return reusableRadioButton(
                                context: context,
                                w: w,
                                e: e,
                                filter: state.sortingFilter.value,
                                onChanged: (value) async {
                                  homeBloc.add(
                                    AllFiltersEvent(
                                      sortingFilter: SortingFilter.fromValue(
                                        value,
                                      ),
                                    ),
                                  );
                                  // Save only updated filters
                                },
                              );
                            }).toList(),
                          ),
                          spacerH(4),
                          Row(
                            children: OrderFilter.values.map((e) {
                              return reusableRadioButton(
                                context: context,
                                filter: state.orderFilter.value,
                                w: w,
                                e: e,
                                onChanged: (value) async {
                                  homeBloc.add(
                                    AllFiltersEvent(
                                      orderFilter: OrderFilter.fromValue(value),
                                    ),
                                  );
                                  // Save only updated filters

                                },
                              );
                            }).toList(),
                          ),
                          spacerH(4),
                          Row(
                            children: StyleFilter.values.map((e) {
                              return reusableRadioButton(
                                context: context,
                                filter: state.styleFilter.value,
                                w: w,
                                e: e,
                                onChanged: (value) async {
                                  homeBloc.add(
                                    AllFiltersEvent(
                                      styleFilter: StyleFilter.fromValue(value),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          // ),
        ],
      ),
    );
  }

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
}
