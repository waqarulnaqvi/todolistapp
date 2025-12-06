part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isShowFilter;
  final bool isShowSearchIcon;
  ///All The Filters
  final OrderFilter orderFilter;
  final SortingFilter sortingFilter;
  final StyleFilter styleFilter;
  final PriorityLevel priorityLevel;
  ///When Add the priority
  final AddPriority addPriority;
  ///Notes
  final List<TodoListModel> notesList;
  ///Error Message
  final String? errorMessage;

  const HomeState({
    this.errorMessage,
    this.isShowFilter = false,
    this.styleFilter = StyleFilter.classic,
    this.orderFilter = OrderFilter.descending,
    this.sortingFilter = SortingFilter.creationDate,
    this.priorityLevel = PriorityLevel.all,
    this.addPriority = AddPriority.high,
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
    addPriority,
    isShowSearchIcon,
  ];

  HomeState copyWith({
    bool? isLoading,
    bool? isShowFilter,
    OrderFilter? orderFilter,
    SortingFilter? sortingFilter,
    StyleFilter? styleFilter,
    AddPriority? addPriority,
    String? errorMessage,
    List<TodoListModel>? notesList,
    PriorityLevel? priorityLevel,
    bool? isShowSearchIcon,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isShowFilter: isShowFilter ?? this.isShowFilter,
      styleFilter: styleFilter ?? this.styleFilter,
      orderFilter: orderFilter ?? this.orderFilter,
      addPriority: addPriority?? this.addPriority,
      sortingFilter: sortingFilter ?? this.sortingFilter,
      errorMessage: errorMessage ?? this.errorMessage,
      notesList: notesList ?? this.notesList,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      isShowSearchIcon: isShowSearchIcon ?? this.isShowSearchIcon,
    );
  }
}
