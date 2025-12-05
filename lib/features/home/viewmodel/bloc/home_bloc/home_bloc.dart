import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../utils/notes_filters.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    // Load saved filters at startup

    // Listen to Hive box changes
    // notesBox.watch().listen((_) => add(FetchNotesEvent()));

    on<AllFiltersEvent>(_allFiltersEvent);
    on<HomeLoadingEvent>(_homeLoadingEvent);
    on<HomeErrorEvent>(_homeErrorEvent);
    on<LoadFiltersEvent>(_loadFilters);

    /// Handles the color selection event
    on<SelectColorEvent>(_selectedColorEvent);

    /// Handles the CRUD operations for notes
    on<AddUpdateNoteEvent>(_addUpdateNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
    on<FetchNotesEvent>(_fetchNotesEvent);


    ///Toggle Search Icon Button
    on<ToggleSearchButtonEvent>(_toggleSearchButtonEvent);

    ///Toggle Filter Button
    on<HomeToggleFilterEvent>(_homeToggleFilterEvent);


    // Trigger initial LoadFiltersEvent in a microtask
    Future.microtask(() {
      add(LoadFiltersEvent());
    });
  }

  /// Toggle Search Icon Button
  void _toggleSearchButtonEvent(
  ToggleSearchButtonEvent event
  ,Emitter<HomeState> emit) {
    emit(state.copyWith(isShowSearchIcon: !state.isShowSearchIcon));
  }

  /// Load saved filters from Hive
  Future<void> _loadFilters(
    LoadFiltersEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // final savedOrder = await hiveHelper.getData(key: HiveHelper.orderFilter);
      // final savedSorting = await hiveHelper.getData(
      //     key: HiveHelper.sortingFilter);
      // final savedStyle = await hiveHelper.getData(key: HiveHelper.styleFilter);
      //
      // // print('savedOrder: $savedOrder, savedSorting: $savedSorting, savedStyle: $savedStyle');
      // emit(
      //   state.copyWith(
      //     orderFilter: savedOrder != null
      //         ? OrderFilter.fromInt(savedOrder)
      //         : state.orderFilter,
      //     sortingFilter: savedSorting != null
      //         ? SortingFilter.fromInt(savedSorting)
      //         : state.sortingFilter,
      //     styleFilter: savedStyle != null
      //         ? StyleFilter.fromInt(savedStyle)
      //         : state.styleFilter,
      //   ),
      // );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }

    // After filters are loaded, fetch notes
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

      // // Save only updated filters
      // await hiveHelper.saveData(key: HiveHelper.orderFilter, value: newOrder);
      // await hiveHelper.saveData(
      //   key: HiveHelper.sortingFilter,
      //   value: newSorting,
      // );
      // await hiveHelper.saveData(key: HiveHelper.styleFilter, value: newStyle);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }

    // Fetch notes after updating filters
    add(FetchNotesEvent());
  }

  void _homeLoadingEvent(HomeLoadingEvent event, Emitter<HomeState> emit) {
    // Handle loading event logic here
  }

  void _homeErrorEvent(HomeErrorEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(errorMessage: event.error));
    // Handle error event logic here
    // emit(state.copyWith(isShowFilter: false));
  }

  /// Handles the color selection event
  void _selectedColorEvent(SelectColorEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedColor: event.selectedColor));
  }

  /// Handles the CRUD operations for notes
  Future<void> _addUpdateNoteEvent(
    AddUpdateNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // final note = MyNotesModel(
      //   title: event.title,
      //   date: event.date,
      //   description: event.description,
      //   color: event.color,
      // );
      //
      // if (event.key != null) {
      //   // Update existing note or add if somehow key does not exist
      //   await notesBox.put(event.key, note);
      // } else {
      //   // Add new note
      //   await notesBox.add(note);
      // }

      // add(FetchNotesEvent());
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
      // await notesBox.delete(event.key);

      // Fetch updated notes after delete
      // add(FetchNotesEvent());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _fetchNotesEvent(
    FetchNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // // Get notes from Hive
      // var notes = notesBox.values.toList();
      //
      // // Apply sorting filter
      // notes.sort((a, b) {
      //   if (state.sortingFilter == SortingFilter.title) {
      //     return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      //   } else if (state.sortingFilter == SortingFilter.datetime) {
      //     return a.date.compareTo(b.date);
      //   }
      //   return 0; // default, no sorting
      // });
      //
      // // Apply order filter (reverse if descending)
      // if (state.orderFilter == OrderFilter.ascending) {
      //   notes = notes.reversed.toList();
      // }
      //
      // emit(state.copyWith(notesList: List<MyNotesModel>.from(notes)));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
