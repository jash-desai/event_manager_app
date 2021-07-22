import 'package:event_manager/models/task.dart';
import 'package:event_manager/providers/database_helper.dart';
import 'package:flutter/material.dart';

import '../models/group.dart';

extension DateOnlyCompare on DateTime {
  bool isDateBefore(DateTime other) {
    return this.year <= other.year &&
        this.month <= other.month &&
        this.day <= other.day;
  }

  bool isDateAfter(DateTime other) {
    return this.year >= other.year &&
        this.month >= other.month &&
        this.day >= other.day;
  }

  bool isDateSame(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class Tasks with ChangeNotifier {
  // ...........Code for handling categories...........

  DateTime selectedDate = DateTime.now();
  List<Group> _categories = [
    Group(
      title: "Work",
      color: Colors.amber,
    ),
    Group(
      title: "School",
      color: Colors.blueAccent,
    ),
  ];

  List<Group> get categories {
    return [..._categories];
  }

  void addCategory(Group grp) {
    if (!_categories.contains(grp)) {
      _categories.add(grp);
    }
    notifyListeners();
  }

  void fetchAndSetTasks() async {
    final List<Map<String, dynamic>> allTasks =
        await DatabaseHelper.instance.queryAll();
    final List<Map<String, dynamic>> allCategories =
        await DatabaseHelper.instance.queryAllCategories();
    allTasks.forEach((taskMap) {
      print(taskMap);
      _tasks.add(Task.fromMap(taskMap));
    });
    allCategories.forEach((catMap) {
      print(catMap);
      _categories.add(Group.fromMap(catMap));
    });
  }

  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> availableTasks(Group category) {
    List<Task> finalList = [];
    finalList = todaysTask
        .where((task) => task.category.title == category.title)
        .toList();
    return finalList;
  }

  List<Task> get todaysTask {
    List<Task> finalList = [];
    _tasks.forEach((task) {
      if (task.date.isDateSame(selectedDate)) {
        finalList.add(task);
      }
    });
    return finalList;
  }

  void addTask(Task task) {
    if (!_tasks.contains(task)) {
      _tasks.add(task);
    }
    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
  }
}
