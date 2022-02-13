import 'package:equatable/equatable.dart';

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
