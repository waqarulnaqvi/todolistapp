import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolistapp/features/home/utils/notes_filters.dart';
import 'package:todolistapp/features/home/view/widgets/buttons/reusable_radio_button.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../shared/view/widgets/buttons/custom_drop_down.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double w = MediaQuery.of(context).size.width;
    final homeBloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(
              context: context,
              colorScheme: colorScheme,
              state: state,
              homeBloc: homeBloc,
            ),
            if (state.isShowFilter)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
                child: DecoratedBox(
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
                                    sortingFilter: SortingFilter.fromValue(value),
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
          ],
        );
      },
    );
  }

  // ---------------------------
  // HEADER ROW
  // ---------------------------
  Widget _buildHeaderRow({
    required BuildContext context,
    required ColorScheme colorScheme,
    required HomeState state,
    required HomeBloc homeBloc,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: CustomDropDown(
              onTap: () {
                if (state.isShowFilter) {
                  homeBloc.add(HomeToggleFilterEvent());
                }
              },
              icon: Icons.arrow_drop_down_rounded,
              categories: PriorityLevel.values.map((e) => e.value).toList(),
              leadingIconSize: 20,
              onChanged: (newValue) {
                if (newValue != null) {
                  homeBloc.add(
                    ChangePriorityLevelEvent(priorityLevel: newValue),
                  );
                }
              },
              selectedValue: state.priorityLevel.value,
              leadingIcon: FontAwesomeIcons.receipt,
              color: colorScheme.onSurface,
              borderColor: colorScheme.onSurface,
            ),
          ),
          spacerW(10),
          Container(
            height: 45.h,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.onSurface),
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                homeBloc.add(HomeToggleFilterEvent());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filters',
                    style: AppStyles.descriptionPrimary(
                      context: context,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  spacerW(10),
                  AnimatedRotation(
                    turns: state.isShowFilter ? 0.5 : 0.0,
                    // 0.5 = 180 degrees
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      Icons.filter_list,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
