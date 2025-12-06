import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todolistapp/core/routes/paths.dart';
import 'package:todolistapp/core/services/notification_permission_helper.dart';
import 'package:todolistapp/core/utils/dialog/dialog_helper.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import 'package:todolistapp/features/home/view/widgets/filter_widget.dart';
import 'package:todolistapp/shared/view/widgets/text_view/reusable_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../shared/view/widgets/containers/reusable_folded_corner_container.dart';
import '../../utils/notes_filters.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/drawer/custom_drawer.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    final double w = size.width;
    final titleController = useTextEditingController();
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final bgColor = isLightTheme
        ? AppColors.appBackgroundColor
        : AppColors.appDarkBackgroundColor;
    final homeBloc = context.read<HomeBloc>();

    void onPressedSearchButton() {
      titleController.clear();
      homeBloc.add(ToggleSearchButtonEvent());
      homeBloc.add(FetchNotesEvent());
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // REQUEST BOTH PERMISSIONS BEFORE ANYTHING ELSE
        await NotificationPermissionHelper.instance.requestAllPermissions();
      });
      return null;
    }, []);


    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, result) =>
          DialogHelper.showYesNoDialog(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        endDrawer: CustomDrawer(w: w * 0.7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppGradients.orangeMyAppGradient,
              ),
            ),
            child: appBar(
              onPressed: onPressedSearchButton,
              theme: theme,
              context: context,
              scaffoldKey: scaffoldKey,
            ),
          ),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
          child: Stack(
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
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    child: Column(
                      children: [
                        spacerH(),
                        BlocSelector<HomeBloc, HomeState, bool>(
                          selector: (state) => state.isShowSearchIcon,
                          builder: (context, isShow) {
                            if (!isShow) return SizedBox.shrink();
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ).copyWith(bottom: 10.h),
                              child: ReusableTextField(
                                controller: titleController,
                                hintText: "Search by Title",
                                onChanged: (value) {
                                    homeBloc.add(
                                      FetchNotesEvent(title: value.trim()),
                                    );
                                },
                                suffixIcon: IconButton(
                                  onPressed: onPressedSearchButton,
                                  icon: Icon(Icons.cancel),
                                ),
                              ),
                            );
                          },
                        ),
                        FilterWidget(),
                        spacerH(10),
                        Expanded(
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
                                  ? _buildClassicList(state)
                                  : _buildGridList(state);
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openNoteManagementPage(context: context),
          backgroundColor: theme.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  /// CLASSIC LIST VIEW
  Widget _buildClassicList(final HomeState state) {
    return ListView.builder(
      itemCount: state.notesList.length,
      padding: EdgeInsets.only(top: 10.h, bottom: 60.h),
      itemBuilder: (context, index) {
        final note = state.notesList[index];

        return Padding(
          padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
          child: ReusableFoldedCornerContainer(
            id: note.id!,
            isReminder: note.isReminder,
            title: note.title,
            description: note.description,
            creationDate: note.creationDate,
            dueDate: note.dueDate,
            priorityColor: AddPriority.fromInt(note.priority).color,
            onTap: () =>
                _openNoteManagementPage(context: context, todoModel: note),
          ),
        );
      },
    );
  }

  /// MASONRY GRID VIEW
  Widget _buildGridList(final HomeState state) {
    return MasonryGridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 60.h),
      shrinkWrap: true,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: state.notesList.length,
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 20.w,
      itemBuilder: (context, i) {
        final note = state.notesList[i];
        final bool isSmall = (i == 0 || i == state.notesList.length - 1);
        final bool isBig = state.notesList.length < 2;

        return Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: ReusableFoldedCornerContainer(
            height: (isBig?320 :isSmall ? 300 : 320).h,
            specialHeight: !isSmall,
            hideDecoration: true,
            id: note.id!,
            isReminder: note.isReminder,
            title: note.title,
            description: note.description,
            creationDate: note.creationDate,
            dueDate: note.dueDate,
            priorityColor: AddPriority.fromInt(note.priority).color,
            onTap: () =>
                _openNoteManagementPage(context: context, todoModel: note),
          ),
        );
      },
    );
  }

  /// NAVIGATION HANDLER
  void _openNoteManagementPage({
    TodoListModel? todoModel,
    required BuildContext context,
  }) {
    Navigator.pushNamed(
      context,
      Paths.notesManagementPage,
      arguments: todoModel,
    );
  }
}
