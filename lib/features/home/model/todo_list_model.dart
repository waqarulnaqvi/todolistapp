import '../../../core/local/db_helper.dart';

class TodoListModel {
  final int? id;
  final String title;
  final String description;
  final String creationDate;
  final String dueDate;
  final int priority;

  TodoListModel({
    this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.dueDate,
    required this.priority,
  });

  /// Convert Map → Model
  factory TodoListModel.fromMap(Map<String, dynamic> map) {
    return TodoListModel(
      id: map[DBHelper.columnTodoId],
      title: map[DBHelper.columnTodoTitle] ?? '',
      description: map[DBHelper.columnTodoDescription] ?? '',
      creationDate: map[DBHelper.columnTodoCreationDate] ?? '',
      dueDate: map[DBHelper.columnTodoDueDate] ?? '',
      priority: map[DBHelper.columnTodoPriority] ?? 0,
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
    };
  }
}
