// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TodoTask extends Equatable {
  final String title;
  bool? isCompleted;
  bool? isDeleted;

  TodoTask({
    required this.title,
    this.isCompleted,
    this.isDeleted,
  }) {
    isCompleted = isCompleted ?? false;
    isDeleted = isDeleted ?? false;
  }

  TodoTask copyWith({
    String? title,
    bool? isCompleted,
    bool? isDeleted,
  }) {
    return TodoTask(
      title: title ?? this.title,
      isCompleted: isCompleted ?? false,
      isDeleted: isDeleted ?? false,
    );
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, isCompleted, isDeleted];
}
