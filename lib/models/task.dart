import 'dart:convert';

import 'package:event_manager/models/group.dart';
import 'package:flutter/material.dart';

extension passTime on TimeOfDay {
  String toExtractableString() {
    return json.encode({
      'hour': this.hour,
      'minute': this.minute,
    });
  }
}

class Task {
  final int id;
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Group category;

  Task({
    this.id,
    this.title,
    this.date,
    this.startTime,
    this.endTime,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'startTime': startTime.toExtractableString(),
      'endTime': endTime.toExtractableString(),
      'category': json.encode({
        'title': category.title,
        'color': category.color.value,
      })
    };
  }

  Task addId(int id) {
    return Task(
      id: id,
      title: this.title,
      date: this.date,
      startTime: this.startTime,
      endTime: this.endTime,
      category: this.category,
    );
  }

  // Task fromMap(Map<String, dynamic> map) {
  //   return Task(
  //     id: map['id'],
  //     title: map['title'],
  //     date: DateTime.parse(map['date']),
  //     startTime: parse(map['start-time']),
  //     endTime: parse(map['end-time']),
  //     category: Group(
  //       color: null,
  //       title: "test",
  //     ),
  //   );
  // }

  factory Task.fromMap(Map<String, dynamic> map) {
    final startTimeData = json.decode(map['startTime']) as Map<String, dynamic>;
    final endTimeData = json.decode(map['endTime']) as Map<String, dynamic>;
    final categoryData = json.decode(map['category']);
    return Task(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        startTime: TimeOfDay(
            hour: startTimeData['hour'], minute: startTimeData['minute']),
        endTime:
            TimeOfDay(hour: endTimeData['hour'], minute: endTimeData['minute']),
        category: Group(
          title: categoryData['title'],
          color: Color(categoryData['color']),
        ));
  }

  // TimeOfDay parse(String jsonData) {
  //   Map<String, dynamic> map = json.decode(jsonData);
  //   return TimeOfDay(hour: map['hour'], minute: map['minute']);
  // }
}
