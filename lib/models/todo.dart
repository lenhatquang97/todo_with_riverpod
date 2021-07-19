import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class Task{
  final String taskName;
  bool isCompleted;
  Task({required this.taskName, this.isCompleted=false});
}
class TaskList extends ChangeNotifier{
  List<Task> tasks=[];
  void addTask(Task task){
    tasks.add(task);
    notifyListeners();
  }
  void deleteTask(int index){
    if(tasks.isEmpty) {
      return;
    }
    tasks.removeAt(index);
    notifyListeners();
  }
  void checkCompleted(int index){
    tasks[index].isCompleted=!tasks[index].isCompleted;
    notifyListeners();
  }
}
final listProvider=ChangeNotifierProvider((ref) => TaskList());