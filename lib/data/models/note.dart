import 'package:equatable/equatable.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class NoteData extends HiveObject{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? date;
  @HiveField(3)
  int? color;
  @HiveField(4)
  String? priority;
}

// ignore: must_be_immutable
class Note extends Equatable {
  int? id;
  final String? title;
  final String? description;
  final String? date;
  final int? color;
  final int? priority;

  Note({
    this.id,
    this.title,
    this.description,
    this.date,
    this.color,
    this.priority,
  });

  Note copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    int? color,
    int? priority,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        color: color ?? this.color,
        priority: priority ?? this.priority,
      );

  @override
  List<Object?> get props => [
        title,
        description,
        date,
        color,
        priority,
      ];

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['noteId'],
        title: json['title'],
        description: json['description'],
        date: json['date'],
        color: json['color'],
        priority: json['priority'],
      );

  Map<String, dynamic> toJson() => {
        'noteId': id,
        'title': title,
        'description': description,
        'date': date,
        'color': color,
        'priority': priority,
      };
}
