import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolistapp/core/constants/static_assets/app_icons.dart';
import 'package:todolistapp/core/routes/paths.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import 'package:todolistapp/shared/view/widgets/text_view/reusable_text_field.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../shared/view/widgets/containers/reusable_folded_corner_container.dart';
import '../../../../shared/view/widgets/theme_controller_widget.dart';
import '../../utils/notes_filters.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/drawer/custom_drawer.dart';
import '../widgets/my_notes_filter.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    final double w = size.width;
    final titleController = useTextEditingController();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final bgColor = isLightTheme
        ? AppColors.appBackgroundColor
        : AppColors.appBackgroundColor.withValues(alpha: 0.8);
    final homeBloc = context.read<HomeBloc>();

    void onPressedSearchButton() {
      titleController.clear();
      homeBloc.add(ToggleSearchButtonEvent());
    }

    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(w: w * 0.7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppGradients.orangeMyAppGradient),
          ),
          child: appBar(
            onPressed: onPressedSearchButton,
            theme: theme,
            context: context,
            scaffoldKey: scaffoldKey,
          ),
        ),
      ),
      backgroundColor: AppColors.appBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppGradients.orangeMyAppGradient,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.appBackgroundColor),
                child: Column(
                  children: [
                    Flexible(
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.isShowSearchIcon) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ).copyWith(top: 20.h),
                              child: ReusableTextField(
                                controller: titleController,
                                hintText: "Search by Title",
                                suffixIcon: IconButton(
                                  onPressed: onPressedSearchButton,
                                  icon: Icon(Icons.cancel),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    spacerH(),
                    MyNotesFilter(),
                    spacerH(10),
                    Flexible(
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.errorMessage != null) {
                            return Center(
                              child: Text(
                                state.errorMessage!,
                                style: AppStyles.descriptionPrimary(
                                  context: context,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }
                          return state.notesList.isEmpty
                              ? Center(
                                  child: state.isLoading
                                      ? CircularProgressIndicator(
                                          color: theme.primary,
                                        )
                                      : Text(
                                          'No Notes Found!',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                )
                              : state.styleFilter.value ==
                                    StyleFilter.classic.value
                              ? ListView.builder(
                                  itemCount: state.notesList.length,
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                    bottom: 80.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    final note = state.notesList[index];

                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: 15.w,
                                        top: 10.h,
                                        bottom: 10.h,
                                      ),
                                      child: ReusableFoldedCornerContainer(
                                        title: note.title,
                                        description: note.description,
                                        date: "",
                                        color: Colors.white,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Paths.notesManagementPage,
                                            arguments: note,
                                          );
                                        },
                                        currKey: 1,
                                      ),
                                    );
                                  },
                                )
                              : MasonryGridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                  itemCount: state.notesList.length,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 20.w,
                                  itemBuilder: (context, index) {
                                    final note = state.notesList[index];
                                    final height =
                                        ((index == 0 ||
                                                    index ==
                                                        state.notesList.length -
                                                            1)
                                                ? 155
                                                : 200)
                                            .h;

                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        bottom: 10.h,
                                      ),
                                      child: ReusableFoldedCornerContainer(
                                        height: height,
                                        specialHeight:
                                            (index == 0 ||
                                                index ==
                                                    state.notesList.length - 1)
                                            ? false
                                            : true,
                                        hideDecoration: true,
                                        title: note.title,
                                        description: note.description,
                                        date: "",
                                        color: Colors.white,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Paths.notesManagementPage,
                                            arguments: note,
                                          );
                                        },
                                        currKey: 0,
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteManagementPage(context: context),
        backgroundColor: theme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// NAVIGATION HANDLER
  void _openNoteManagementPage({
    TodoListModel? budget,
    required BuildContext context,
  }) {
    Navigator.pushNamed(context, Paths.notesManagementPage, arguments: budget);
  }
}
