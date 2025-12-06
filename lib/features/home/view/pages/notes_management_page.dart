import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:todolistapp/core/theme/app_styles.dart';
import 'package:todolistapp/core/utils/date_time_utils.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import 'package:todolistapp/features/home/utils/notes_filters.dart';
import 'package:todolistapp/features/home/view/widgets/buttons/reusable_radio_button.dart';
import 'package:todolistapp/shared/view/widgets/containers/date_time_info_box.dart';
import '../../../../core/utils/util.dart';
import '../../../../shared/view/widgets/reusable_app_bar.dart';
import '../../../../shared/view/widgets/text_view/reusable_text_field.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class NotesManagementPage extends HookWidget {
  final TodoListModel? myNotesModel;

  const NotesManagementPage({super.key, this.myNotesModel});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final theme = Theme.of(context).colorScheme;
    final double w = MediaQuery.of(context).size.width;
    final isReminder = useState(false);
    final dueDate=useState(formatDateTimeNow(isDueDate: true));
    final headingText= myNotesModel!=null ? "Update Note" :"Add Note";
    /// update UI if editing existing note
    useEffect(() {
      if (myNotesModel != null) {
        titleController.text = myNotesModel!.title;
        descriptionController.text = myNotesModel!.description;
        isReminder.value = myNotesModel!.isReminder;
        dueDate.value=myNotesModel!.dueDate;
        homeBloc.add(
          AddPriorityTodoEvent(
            changePriority: AddPriority.fromInt(myNotesModel!.priority).value,
          ),
        );
      }
      return null;
    }, []);


    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.addPriority.color,
          appBar: ReusableAppBar(
            text: headingText,
            isCenterText: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacerH(40),

                      /// ✅ Title
                      ReusableTextField(
                        prefixIcon: Icons.title_outlined,
                        controller: titleController,
                        hintText: "Enter Title",
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Title cannot be empty";
                          }
                          return null;
                        },
                      ),
                      spacerH(),

                      /// ✅ Description
                      ReusableTextField(
                        prefixIcon: Icons.title_outlined,
                        controller: descriptionController,
                        hintText: "Enter Description",
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Description cannot be empty";
                          }
                          return null;
                        },
                      ),
                      spacerH(10),
                      prioritySection(
                        context: context,
                        w: w,
                        homeBloc: homeBloc,
                      ),
                      spacerH(10),

                      InkWell(
                        onTap: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2000, 1, 1),
                            maxTime: DateTime(2100, 12, 31),
                            onConfirm: (dateTime) {
                              dueDate.value=formatDateTimeNow(customDateTime:dateTime );
                            },
                            currentTime: parseFormattedDateTime(dueDate.value),
                          );

                        },
                        child: DateTimeInfoBox(
                          label: "Due Date/Time",
                          dateTime: dueDate.value,
                          textColor: theme.onSurface,
                          bgColor: theme.surface,
                          isClassic: true,
                           fontSize: 16,
                          fontWeight :FontWeight.w500,
                            insidePadding:10
                        ),

                      ),

                      spacerH(10),
                      InkWell(
                        onTap: () {
                          isReminder.value = !isReminder.value;
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.black,
                              value: isReminder.value,
                              checkColor: theme.primary,
                              onChanged: (val) {
                                isReminder.value = val ?? false;
                              },
                            ),
                            Text(
                              "Reminder",
                              style: AppStyles.descriptionPrimary(
                                context: context,
                              ),
                            ),
                          ],
                        ),
                      ),
                      spacerH(10),
                      ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            IconSnackBar.show(
                              context,
                              label: "Please fill all required fields",
                              snackBarType: SnackBarType.alert,
                            );
                            return;
                          }

                          /// format current datetime
                          final creationDate = formatDateTimeNow();

                          if (myNotesModel != null) {
                            homeBloc.add(
                              UpdateNoteEvent(
                                title: titleController.text,
                                description: descriptionController.text,
                                creationDate: creationDate,
                                dueDate: dueDate.value,
                                priority: AddPriority.toInt(
                                  state.addPriority.value,
                                ),
                                isReminder: isReminder.value,
                                id: myNotesModel!.id ?? 0,
                              ),
                            );
                          } else {
                            homeBloc.add(
                              AddNoteEvent(
                                title: titleController.text,
                                description: descriptionController.text,
                                creationDate: creationDate,
                                dueDate: dueDate.value,
                                priority: AddPriority.toInt(
                                  state.addPriority.value,
                                ),
                                isReminder: isReminder.value,
                              ),
                            );
                          }

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          minimumSize: Size(w, 45),
                          backgroundColor: theme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          headingText,
                          style: AppStyles.descriptionPrimary(
                            context: context,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget prioritySection({
    required BuildContext context,
    required double w,
    required homeBloc,
  }) {
    final priorities = AddPriority.values; // Low, Medium, High (enum)

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: priorities.map((priority) {
            return reusableRadioButton(
              context: context,
              filter: state.addPriority.value,
              w: w,
              e: priority,
              onChanged: (value) {
                homeBloc.add(AddPriorityTodoEvent(changePriority: value));
              },
            );
          }).toList(),
        );
      },
    );
  }
}