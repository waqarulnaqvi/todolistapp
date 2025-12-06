import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todolistapp/core/theme/app_colors.dart';

/// Defines sorting options for the todoList.
/// `title` = Alphabetical sorting by title
/// `dueDate` = Sort by the task's due date
/// `creationDate` = Sort by the date the task was created
enum SortingFilter {
  dueDate("Due Date"),
  creationDate("Creation Date");

  /// Display label for UI.
  final String value;

  const SortingFilter(this.value);

  /// Convert display text → enum.
  /// Defaults to `SortingFilter.dueDate` if no match is found.
  static SortingFilter fromValue(String value) =>
      SortingFilter.values.firstWhere(
            (e) => e.value == value,
        orElse: () => SortingFilter.dueDate, // fallback fixed
      );

  /// Convert index → enum, safe with bounds using clamp.
  static SortingFilter fromInt(int index) =>
      SortingFilter.values[index.clamp(0, SortingFilter.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String sorting) =>
      SortingFilter.values.indexWhere((e) => e.value == sorting);
}




/// Defines the order direction for sorting.
/// `ascending` = A→Z / Oldest first
/// `descending` = Z→A / Newest first
enum OrderFilter {
  ascending("Ascending"),
  descending("Descending");

  final String value;
  const OrderFilter(this.value);

  /// Convert display text → enum.
  static OrderFilter fromValue(String value) =>
      OrderFilter.values.firstWhere(
            (e) => e.value == value,
        orElse: () => OrderFilter.ascending,
      );

  /// Convert index → enum.
  static OrderFilter fromInt(int index) =>
      OrderFilter.values[index.clamp(0, OrderFilter.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String order) =>
      OrderFilter.values.indexWhere((e) => e.value == order);
}

/// Defines UI layout style for budgets.
/// `classic` = normal list
/// `staggered` = masonry-style grid
enum StyleFilter {
  classic("Classic"),
  staggered("Staggered");

  final String value;
  const StyleFilter(this.value);

  /// Convert display text → enum.
  static StyleFilter fromValue(String value) =>
      StyleFilter.values.firstWhere(
            (e) => e.value == value,
        orElse: () => StyleFilter.classic,
      );

  /// Convert index → enum.
  static StyleFilter fromInt(int index) =>
      StyleFilter.values[index.clamp(0, StyleFilter.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String style) =>
      StyleFilter.values.indexWhere((e) => e.value == style);
}


/// Defines priority levels for tasks.
/// `all` = No filtering, show every task
/// `low` = Low importance
/// `medium` = Medium importance
/// `high` = High importance
enum PriorityLevel {
  all("All"),
  low("Low Priority"),
  medium("Medium Priority"),
  high("High Priority");

  /// Display label for UI.
  final String value;

  const PriorityLevel(this.value);

  /// Convert display text → enum.
  /// Defaults to `PriorityLevel.all` if no match is found.
  static PriorityLevel fromValue(String value) =>
      PriorityLevel.values.firstWhere(
            (e) => e.value == value,
        orElse: () => PriorityLevel.all,
      );

  /// Convert index → enum using safe clamping.
  static PriorityLevel fromInt(int index) =>
      PriorityLevel.values[index.clamp(0, PriorityLevel.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String priority) =>
      PriorityLevel.values.indexWhere((e) => e.value == priority);
}


enum AddPriority {
  low("Low"),
  medium("Medium"),
  high("High");

  /// Display label for UI.
  final String value;

  const AddPriority(this.value);

  /// Priority color for UI.
  Color get color {
    switch (this) {
      case AddPriority.low:
        return AppColors.lightGreen;
      case AddPriority.medium:
        return AppColors.lightBlue;
      case AddPriority.high:
        return AppColors.redOrange;
    }
  }

  /// Convert display text → enum.
  static AddPriority fromValue(String value) =>
      AddPriority.values.firstWhere(
            (e) => e.value == value,
        orElse: () => AddPriority.low,
      );

  /// Convert index → enum using safe clamping.
  static AddPriority fromInt(int index) =>
      AddPriority.values[index.clamp(0, AddPriority.values.length - 1)];

  /// Convert display text → index.
  static int toInt(String priority) =>
      AddPriority.values.indexWhere((e) => e.value == priority);
}

