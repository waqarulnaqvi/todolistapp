import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/core/services/alarm_callback.dart';
import 'package:todolistapp/core/utils/date_time_utils.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import '../../../utils/notes_filters.dart';
import 'package:todolistapp/core/local/db_helper.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  DBHelper _dbHelper = DBHelper();

  HomeBloc() : super(const HomeState()) {
    on<AllFiltersEvent>(_allFiltersEvent);
    on<HomeLoadingEvent>(_homeLoadingEvent);
    on<HomeErrorEvent>(_homeErrorEvent);

    /// Handles the CRUD operations for notes
    on<AddNoteEvent>(_addNoteEvent);
    on<UpdateNoteEvent>(_updateNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
    on<FetchNotesEvent>(_fetchNotesEvent);

    ///Toggle Search Icon Button
    on<ToggleSearchButtonEvent>(_toggleSearchButtonEvent);

    ///Toggle Filter Button
    on<HomeToggleFilterEvent>(_homeToggleFilterEvent);

    ///Change Priority Filter
    on<ChangePriorityLevelEvent>(_changePriorityLevelEvent);

    ///Add Priority in the while Add the Nodes
    on<AddPriorityTodoEvent>(_addPriorityTodoEvent);

    ///Loading true;

    add(HomeLoadingEvent(isLoading: true));
    add(FetchNotesEvent());
  }

  ///Add Priority in the while Add the Nodes
  void _addPriorityTodoEvent(
    AddPriorityTodoEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(addPriority: AddPriority.fromValue(event.changePriority)),
    );
  }

  /// Toggle Search Icon Button
  void _toggleSearchButtonEvent(
    ToggleSearchButtonEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isShowSearchIcon: !state.isShowSearchIcon));
  }

  ///Priority Filters
  void _changePriorityLevelEvent(
    ChangePriorityLevelEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        priorityLevel: PriorityLevel.fromValue(event.priorityLevel),
      ),
    );

    add(FetchNotesEvent());
  }

  /// Handles the toggle filter event
  void _homeToggleFilterEvent(
    HomeToggleFilterEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isShowFilter: !state.isShowFilter));
  }

  /// Handles all the filters
  Future<void> _allFiltersEvent(
    AllFiltersEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // Update the state with the new filters
      final String newOrder = (event.orderFilter ?? state.orderFilter).value;
      final String newSorting =
          (event.sortingFilter ?? state.sortingFilter).value;
      final String newStyle = (event.styleFilter ?? state.styleFilter).value;

      emit(
        state.copyWith(
          orderFilter: OrderFilter.fromValue(newOrder),
          sortingFilter: SortingFilter.fromValue(newSorting),
          styleFilter: StyleFilter.fromValue(newStyle),
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }

    // Fetch notes after updating filters
    add(FetchNotesEvent());
  }

  void _homeLoadingEvent(HomeLoadingEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
    // Handle loading event logic here
  }

  void _homeErrorEvent(HomeErrorEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(errorMessage: event.error));
    // Handle error event logic here
    // emit(state.copyWith(isShowFilter: false));
  }

  ///Local Database All the commands
  /// Handles the CRUD operations for notes
  Future<void> _addNoteEvent(
    AddNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final note = TodoListModel(
        isReminder: event.isReminder,
        title: event.title,
        description: event.description,
        creationDate: event.creationDate,
        dueDate: event.dueDate,
        priority: event.priority,
      );
      bool isValueAdded = await _dbHelper.addTodoListData(note);
      if (isValueAdded) {
        print("is value Added $isValueAdded");
        add(FetchNotesEvent());
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _updateNoteEvent(
    UpdateNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final note = TodoListModel(
        id: event.id,
        isReminder: event.isReminder,
        title: event.title,
        description: event.description,
        creationDate: event.creationDate,
        dueDate: event.dueDate,
        priority: event.priority,
      );

      bool isValueUpdated = await _dbHelper.updateTodoListData(note);

      if (isValueUpdated) {
        print("is value Added $isValueUpdated");
        add(FetchNotesEvent());
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _deleteNoteEvent(
    DeleteNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // Delete note using key
      bool isValueAdded = await _dbHelper.deleteTodoListData(event.key);

      if (isValueAdded) {
        add(FetchNotesEvent());
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _fetchNotesEvent(
    FetchNotesEvent event,
    Emitter<HomeState> emit,
  ) async
  {
    try {
      List<TodoListModel> noteList = await _dbHelper.fetchTodoListData();

      ///Set All the reminders
      for (var note in noteList) {
        if (note.isReminder == true) {
          final due = parseFormattedDateTime(note.dueDate);
          final now = DateTime.now();
            // schedule alarm
            if (due.isAfter(now)) {
              final scheduled = await AndroidAlarmManager.oneShotAt(
                due,
                note.id!,
                alarmCallback,
                exact: true,
                wakeup: true,
                params: {
                  "id": note.id!,
                  "title": note.title,
                  "description": note.description
                },
              );

              if (scheduled) {
                print("⏰ Reminder SET SUCCESSFULLY → ID: ${note.id}, Time: $due");
              } else {
                print("❌ Reminder FAILED to schedule → ID: ${note.id}");
              }
          }
        }
      }

      ///Top Level first check the title
      if(event.title!=null && event.title!.isNotEmpty)
        {
          noteList = noteList.where(
                  (note) => note.title.toLowerCase().contains(event.title!.toLowerCase())
          ).toList();

        }

      ///Second Level then check the priority level
      if (state.priorityLevel == PriorityLevel.all) {
        // DO NOTHING → show all notes
        print("Priority filter: ALL");
      }
      else if (state.priorityLevel == PriorityLevel.low) {
        noteList = noteList.where((note) => note.priority == 0).toList();
        print("Priority filter: LOW = ${noteList.length}");
      }
      else if (state.priorityLevel == PriorityLevel.medium) {
        noteList = noteList.where((note) => note.priority == 1).toList();
        print("Priority filter: MEDIUM = ${noteList.length}");
      }
      else if (state.priorityLevel == PriorityLevel.high) {
        noteList = noteList.where((note) => note.priority == 2).toList();
        print("Priority filter: HIGH = ${noteList.length}");
      }


      ///Then apply all the others filters
      if (state.sortingFilter == SortingFilter.creationDate) {
        // Sort by creation date (latest first or earliest first)
        noteList.sort(
          (a, b) => parseFormattedDateTime(
            a.creationDate,
          ).compareTo(parseFormattedDateTime(b.creationDate)),
        );
      } else if (state.sortingFilter == SortingFilter.dueDate) {
        // Convert dueDate String → DateTime if needed
        noteList.sort(
          (a, b) => parseFormattedDateTime(
            a.dueDate,
          ).compareTo(parseFormattedDateTime(b.dueDate)),
        );
      }

      // 3. Order filter
      if (state.orderFilter == OrderFilter.descending) {
        noteList = noteList.reversed.toList();
      } else if (state.orderFilter == OrderFilter.ascending) {
        noteList = noteList.toList();
      }

      // 4. Emit final updated state
      emit(state.copyWith(notesList: noteList, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
