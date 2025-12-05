part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// Event to toggle the filter visibility in the home page
class HomeToggleFilterEvent extends HomeEvent {

  const HomeToggleFilterEvent();
}

/// Event to handle all the filters in the home page
class AllFiltersEvent extends HomeEvent {
  final OrderFilter? orderFilter;
  final SortingFilter? sortingFilter;
  final StyleFilter? styleFilter;

  const AllFiltersEvent({
    this.orderFilter,
    this.sortingFilter,
    this.styleFilter,
  });

  @override
  List<Object?> get props => [orderFilter, sortingFilter, styleFilter];
}

class HomeLoadingEvent extends HomeEvent {
  const HomeLoadingEvent();
}
class HomeErrorEvent extends HomeEvent {
  final String error;

  const HomeErrorEvent({required this.error});
}

class LoadFiltersEvent extends HomeEvent {
  const LoadFiltersEvent();
}

class SelectColorEvent extends HomeEvent {
  final Color selectedColor;

  const SelectColorEvent({required this.selectedColor});

  @override
  List<Object?> get props => [selectedColor];
}

/// Event to CRUD notes in the home page
class AddUpdateNoteEvent extends HomeEvent {
  final int? key;
  final String title;
  final String date;
  final int color;
  final String description;

  const AddUpdateNoteEvent({
    this.key,
    required this.title,
    required this.date,
    required this.color,
    required this.description,
  });

  @override
  List<Object?> get props => [key, title, date, color, description];
}

class DeleteNoteEvent extends HomeEvent {
  final int key;

  const DeleteNoteEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class FetchNotesEvent extends HomeEvent {
  const FetchNotesEvent();
}



/// Toggle Search Icon

class ToggleSearchButtonEvent extends HomeEvent {
  const ToggleSearchButtonEvent();
}