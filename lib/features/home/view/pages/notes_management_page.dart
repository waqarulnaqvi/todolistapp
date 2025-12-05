import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/util.dart';
import '../../../../shared/view/widgets/reusable_app_bar.dart';
import '../../../../shared/view/widgets/text_view/reusable_text_field.dart';
import '../../viewmodel/bloc/home_bloc/home_bloc.dart';

class NotesManagementPage extends HookWidget {
  final TodoListModel? myNotesModel;

  const NotesManagementPage({super.key, this.myNotesModel});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    /// format current datetime
    final dateTimeString = formatDateTime();

    /// update UI if editing existing note
    useEffect(() {
      if (myNotesModel != null) {
        titleController.text = myNotesModel!.title;
        descriptionController.text = myNotesModel!.description;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // homeBloc.add(
          //   SelectColorEvent(selectedColor: myNotesModel!.colorValue),
          // );
        });
      }
      return null;
    }, []);

    /// back or save logic
    void onBackButtonPressed([bool isBackButton = true]) {
      if (titleController.text.isEmpty && descriptionController.text.isEmpty) {
        if (isBackButton) {
          Navigator.pop(context);
        } else {
          IconSnackBar.show(
            context,
            label: "Both title & description are empty!",
            snackBarType: SnackBarType.alert,
          );
        }
        return;
      }

      // print("Selected Color: ${homeBloc.state.selectedColor}");
      // print("MyNotesModel Color: ${myNotesModel?.color}");
      // print("MyNotesModel ColorValue: ${myNotesModel?.colorValue}");
      // print("mynotesMode key : ${myNotesModel?.key}");


      // homeBloc.add(
      //   AddUpdateNoteEvent(
      //     key: myNotesModel?.key,
      //     title: titleController.text,
      //     description: descriptionController.text,
      //     date: dateTimeString,
      //     color: Colors.white,
      //   ),
      // );

      Navigator.pop(context);
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: ReusableAppBar(
            onPressedBackButton: onBackButtonPressed,
            text: "Add Todo",
            isCenterText: false,
          ),
          backgroundColor: state.selectedColor,
          body: SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                onBackButtonPressed();
                return false; // prevent auto pop, handled manually
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ✅ Save button
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 10,
                          bottom: 2,
                        ),
                        child: InkWell(
                          onTap: () => onBackButtonPressed(false),
                          child: const Icon(
                            FontAwesomeIcons.check,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
            
                    /// ✅ Color selection
                    // SizedBox(
                    //   height: 65,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: selectedColorContents(homeBloc).length,
                    //     itemBuilder: (_, index) {
                    //       final color = selectedColorContents(
                    //         homeBloc,
                    //       )[index].color;
                    //       final onTap = selectedColorContents(
                    //         homeBloc,
                    //       )[index].onTap;
                    //       return GestureDetector(
                    //         onTap: onTap,
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(left: 10, top: 10),
                    //           child: Card(
                    //             elevation: 4,
                    //             shape: const CircleBorder(),
                    //             child: Container(
                    //               width: 65,
                    //               height: 65,
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                   color: state.selectedColor == color
                    //                       ? Colors.black
                    //                       : Colors.white,
                    //                   width: 2,
                    //                 ),
                    //                 shape: BoxShape.circle,
                    //                 color: color,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    spacerH(),
            
                    /// ✅ Date
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    //   child: Text(
                    //     myNotesModel?.date ?? dateTimeString,
                    //     style: AppStyles.descriptionPrimary(
                    //       context: context,
                    //       color: Colors.black,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    // ),
                    spacerH(10),
            
                    /// ✅ Title
                    ReusableTextField(
                      controller: titleController,
                      hintText: "Heading",
                      isBorder: false,
                      maxLines: null,
                      isHeading: true,
                      keyboardType: TextInputType.multiline,
                      filled: false,
                    ),
                    spacerH(20),
            
                    /// ✅ Description
                    ReusableTextField(
                      controller: descriptionController,
                      hintText: "Description",
                      maxLines: null,
                      isBorder: false,
                      keyboardType: TextInputType.multiline,
                      filled: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// ✅ Formatted current date time string
  String formatDateTime() {
    final List dateTime = DateTime.now().toString().split(".")[0].split(" ");
    dateTime[0] = dateTime[0].replaceAll("-", "/");
    var twelveHoursSystem = int.parse(dateTime[1].substring(0, 2));
    if (twelveHoursSystem == 12) {
      dateTime[1] = "${dateTime[1]} PM";
    } else if (twelveHoursSystem > 12) {
      twelveHoursSystem -= 12;
      dateTime[1] =
          "$twelveHoursSystem${dateTime[1].substring(2, dateTime[1].length)} PM";
    } else {
      dateTime[1] = "${dateTime[1]} AM";
    }
    return "${dateTime[0]} | ${dateTime[1]}";
  }
}
