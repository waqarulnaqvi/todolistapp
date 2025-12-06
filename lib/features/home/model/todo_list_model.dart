import '../../../core/local/db_helper.dart';

class TodoListModel {
  final int? id;
  final String title;
  final String description;
  final String creationDate;
  final String dueDate;
  final int priority;
  final bool isReminder;

  TodoListModel({
    this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.dueDate,
    required this.priority,
    required this.isReminder,
  });

  /// Convert Map → Model
  factory TodoListModel.fromMap(Map<String, dynamic> map) {
    return TodoListModel(
      id: map[DBHelper.columnTodoId] as int?,
      title: map[DBHelper.columnTodoTitle] ?? '',
      description: map[DBHelper.columnTodoDescription] ?? '',
      creationDate: map[DBHelper.columnTodoCreationDate] ?? '',
      dueDate: map[DBHelper.columnTodoDueDate] ?? '',
      priority: map[DBHelper.columnTodoPriority] ?? 0,
      isReminder: (map[DBHelper.columnTodoReminder] ?? 0) == 1,
    );
  }

  /// Convert Model → Map
  Map<String, dynamic> toMap() {
    return {
      DBHelper.columnTodoId: id,
      DBHelper.columnTodoTitle: title,
      DBHelper.columnTodoDescription: description,
      DBHelper.columnTodoCreationDate: creationDate,
      DBHelper.columnTodoDueDate: dueDate,
      DBHelper.columnTodoPriority: priority,
      DBHelper.columnTodoReminder : isReminder==true?1 :0
    };
  }
}
