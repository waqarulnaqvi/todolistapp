part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

///Toggles
/// Event to toggle the filter visibility in the home page
class HomeToggleFilterEvent extends HomeEvent {
  const HomeToggleFilterEvent();
}

/// Toggle Search Icon
class ToggleSearchButtonEvent extends HomeEvent {
  const ToggleSearchButtonEvent();
}

/// Event to handle all the filters in the home page
class AllFiltersEvent extends HomeEvent {
  final PriorityLevel? priorityFilter;
  final OrderFilter? orderFilter;
  final SortingFilter? sortingFilter;
  final StyleFilter? styleFilter;

  const AllFiltersEvent({
    this.priorityFilter,
    this.orderFilter,
    this.sortingFilter,
    this.styleFilter,
  });

  @override
  List<Object?> get props => [priorityFilter,orderFilter, sortingFilter, styleFilter];
}

class HomeLoadingEvent extends HomeEvent {
  final bool isLoading;
  const HomeLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class HomeErrorEvent extends HomeEvent {
  final String error;

  const HomeErrorEvent({required this.error});
  @override
  List<Object?> get props => [error];
}


/// Changing the current priority of the
class ChangePriorityLevelEvent extends HomeEvent {
  final String priorityLevel;

  const ChangePriorityLevelEvent({required this.priorityLevel});

  @override
  List<Object?> get props => [priorityLevel];
}

class AddPriorityTodoEvent extends HomeEvent {
  final String changePriority;

  const AddPriorityTodoEvent({required this.changePriority});

  @override
  List<Object?> get props => [changePriority];
}


/// Event to CRUD notes in the home page
/// ADD NOTES
class AddNoteEvent extends HomeEvent {
  final String title;
  final String description;
  final String creationDate;
  final String dueDate;
  final int priority;
  final bool isReminder;

  const AddNoteEvent({
    required this.title,
    required this.description,
    required this.creationDate,
    required this.dueDate,
    required this.priority,
    required this.isReminder,
  });

  @override
  List<Object?> get props => [ title, description, creationDate, dueDate,priority,isReminder];
}

/// UPDATE NOTES
class UpdateNoteEvent extends HomeEvent {
  final int id;
  final String title;
  final String description;
  final String creationDate;
  final String dueDate;
  final int priority;
  final bool isReminder;

  const UpdateNoteEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.dueDate,
    required this.priority,
    required this.isReminder,
  });

  @override
  List<Object?> get props => [id, title, description, creationDate, dueDate,priority,isReminder];
}

///DELETE NOTES
class DeleteNoteEvent extends HomeEvent {
  final int key;

  const DeleteNoteEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

///FETCH NOTES
class FetchNotesEvent extends HomeEvent {
  final String? title;
  const FetchNotesEvent({this.title});
  @override
  List<Object?> get props => [ title];
}
