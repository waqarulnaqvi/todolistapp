import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/home/model/todo_list_model.dart';

class DBHelper {
  /// TABLE NAME
  static const String todoListTableName = "todo_list";

  /// COLUMN NAMES (Your final version)
  static const String columnTodoId = 'todo_id';
  static const String columnTodoTitle = 'todo_title';
  static const String columnTodoDescription = 'todo_description';
  static const String columnTodoCreationDate = 'todo_creation_date';
  static const String columnTodoDueDate = 'todo_due_date';
  static const String columnTodoPriority = 'todo_priority';
  static const String columnTodoReminder = 'todo_reminder';

  // Private constructor
  DBHelper._private();

  // Singleton instance
  static final DBHelper _instance = DBHelper._private();

  // Factory
  factory DBHelper() => _instance;

  Database? _myDB;

  Future<Database> getDB() async {
    return _myDB ??= await openDB();
  }

  Future<Database> openDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "todo_list.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $todoListTableName (
            $columnTodoId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTodoTitle TEXT,
            $columnTodoDescription TEXT,
            $columnTodoCreationDate TEXT,
            $columnTodoDueDate TEXT,
            $columnTodoPriority INTEGER,
            $columnTodoReminder INTEGER
          )
        ''');
      },
    );
  }

  /// ADD TodoData
  Future<bool> addTodoListData(TodoListModel todo) async {
    try {
      Database db = await getDB();
      int rows = await db.insert(todoListTableName, todo.toMap());
      return rows > 0;
    } catch (e) {
      if (kDebugMode) print("Add error → $e");
      return false;
    }
  }

  /// FETCH Todos
  Future<List<TodoListModel>> fetchTodoListData() async {
    try {
      Database db = await getDB();
      List<Map<String, dynamic>> raw = await db.query(todoListTableName);

      return raw.map((e) => TodoListModel.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) print("Fetch error → $e");
      return [];
    }
  }

  /// GET TodoData by ID
  Future<TodoListModel?> getTodoById(int id) async {
    Database db = await getDB();

    final res = await db.query(
      todoListTableName,
      where: "$columnTodoId = ?",
      whereArgs: [id],
    );

    if (res.isNotEmpty) {
      return TodoListModel.fromMap(res.first);
    }
    return null;
  }

  /// UPDATE TodoData
  Future<bool> updateTodoListData(TodoListModel todo) async {
    try {
      Database db = await getDB();

      int rows = await db.update(
        todoListTableName,
        todo.toMap(),
        where: "$columnTodoId = ?",
        whereArgs: [todo.id],
      );

      return rows > 0;
    } catch (e) {
      if (kDebugMode) print("Update error → $e");
      return false;
    }
  }

  /// DELETE TodoData
  Future<bool> deleteTodoListData(int id) async {
    try {
      Database db = await getDB();

      int rows = await db.delete(
        todoListTableName,
        where: "$columnTodoId = ?",
        whereArgs: [id],
      );

      return rows > 0;
    } catch (e) {
      if (kDebugMode) print("Delete error → $e");
      return false;
    }
  }
}
