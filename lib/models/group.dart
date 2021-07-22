import 'dart:ui';

import 'package:flutter/material.dart';

class Group {
  final int id;
  final String title;
  final IconData icon;
  final Color color;

  Group({
    this.id,
    this.title,
    this.icon,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryTitle': title,
      'color': color.value,
    };
  }

  Group addId(int id) {
    return Group(
      id: id,
      title: this.title,
      color: this.color,
    );
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      title: map['categoryTitle'],
      color: Color(map['color']),
    );
  }
}
