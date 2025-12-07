import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todolistapp/features/home/viewmodel/bloc/home_bloc/home_bloc.dart';
import 'package:todolistapp/core/local/db_helper.dart';
import 'package:todolistapp/features/home/model/todo_list_model.dart';

/// ---------------------------
/// MOCK
/// ---------------------------
class MockDBHelper extends Mock implements DBHelper {}

/// ---------------------------
/// FAKE MODEL
/// ---------------------------
class TodoListModelFake extends Fake implements TodoListModel {}

TodoListModel fakeNote() {
  return TodoListModel(
    id: 1,
    title: "Test",
    description: "desc",
    creationDate: "2025/01/01 10:00",
    dueDate: "2025/01/02 10:00",
    priority: 0,
    isReminder: false,
  );
}

void main() {
  late MockDBHelper mockDB;

  setUpAll(() {
    registerFallbackValue(TodoListModelFake());
  });

  setUp(() {
    mockDB = MockDBHelper();
  });

  // ============================================================================
  // TEST 1: FETCH NOTES
  // ============================================================================
  blocTest<HomeBloc, HomeState>(
    'FetchNotesEvent → loads notes from DB',
    build: () {
      when(() => mockDB.fetchTodoListData())
          .thenAnswer((_) async => [fakeNote()]);
      return HomeBloc(dbHelper: mockDB);
    },
    act: (bloc) => bloc.add(FetchNotesEvent()),
    skip: 2, // skip auto-init states
    expect: () => [
      isA<HomeState>()
          .having((s) => s.notesList.length, "should contain 1 note", 1),
    ],
  );

  // ============================================================================
  // TEST 2: ADD NOTE
  // ============================================================================
  blocTest<HomeBloc, HomeState>(
    'AddNoteEvent → inserts note & fetches list',
    build: () {
      when(() => mockDB.addTodoListData(any())).thenAnswer((_) async => true);
      when(() => mockDB.fetchTodoListData())
          .thenAnswer((_) async => [fakeNote()]);

      return HomeBloc(dbHelper: mockDB);
    },
    act: (bloc) {
      bloc.add(AddNoteEvent(
        title: "A",
        description: "D",
        creationDate: "2025/01/01 10:00",
        dueDate: "2025/01/02 10:00",
        priority: 0,
        isReminder: false,
      ));
    },
    skip: 2, // skip initial fetch events
    expect: () => [
      isA<HomeState>()
          .having((s) => s.notesList.length, "after add", 1),
    ],
  );

  // ============================================================================
  // TEST 3: TOGGLE SEARCH
  // ============================================================================
  blocTest<HomeBloc, HomeState>(
    'ToggleSearchButtonEvent → toggles search icon',
    build: () {
      when(() => mockDB.fetchTodoListData()).thenAnswer((_) async => []);
      return HomeBloc(dbHelper: mockDB);
    },
    act: (bloc) => bloc.add(ToggleSearchButtonEvent()),
    skip: 2, // ignore constructor emissions
    expect: () => [
      isA<HomeState>()
          .having((s) => s.isShowSearchIcon, "search icon", true),
    ],
  );
}
