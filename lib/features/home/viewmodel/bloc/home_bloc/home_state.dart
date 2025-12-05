part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowFilter;
  final bool isLoading;
  final Color selectedColor;
  final OrderFilter orderFilter;
  final SortingFilter sortingFilter;
  final StyleFilter styleFilter;
  final String? errorMessage;
  final PriorityLevel priorityLevel;
  final List<TodoListModel> notesList;
  final bool isShowSearchIcon;

  const HomeState({
    this.errorMessage,
    this.isShowFilter = false,
    this.styleFilter = StyleFilter.staggered,
    this.orderFilter = OrderFilter.descending,
    this.sortingFilter = SortingFilter.creationDate,
    this.selectedColor = AppColors.redOrange,
    this.priorityLevel = PriorityLevel.all,
    this.notesList = const [],
    this.isLoading = false,
    this.isShowSearchIcon = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    isShowFilter,
    orderFilter,
    styleFilter,
    sortingFilter,
    priorityLevel,
    errorMessage,
    notesList,
    selectedColor,
    isShowSearchIcon,
  ];

  HomeState copyWith({
    bool? isLoading,
    bool? isShowFilter,
    OrderFilter? orderFilter,
    SortingFilter? sortingFilter,
    StyleFilter? styleFilter,
    String? errorMessage,
    List<TodoListModel>? notesList,
    Color? selectedColor,
    PriorityLevel? priorityLevel,
    bool? isShowSearchIcon,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isShowFilter: isShowFilter ?? this.isShowFilter,
      styleFilter: styleFilter ?? this.styleFilter,
      orderFilter: orderFilter ?? this.orderFilter,
      sortingFilter: sortingFilter ?? this.sortingFilter,
      errorMessage: errorMessage ?? this.errorMessage,
      notesList: List.unmodifiable(notesList ?? this.notesList),
      selectedColor: selectedColor ?? this.selectedColor,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      isShowSearchIcon: isShowSearchIcon ?? this.isShowSearchIcon,
    );
  }
}
