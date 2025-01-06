import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_app/enums/task_action_enum.dart';
import 'package:task_app/models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');
  List<Task> _tasks = [];  
  TaskActionEnum _taskActionEnum = TaskActionEnum.nothing; 

  void setTaskActionEnum(TaskActionEnum taskActionEnum) {
    _taskActionEnum = taskActionEnum;
    loadTasks();
  } 
  
  void loadTasks() {

    if (_taskActionEnum == TaskActionEnum.todo || _taskActionEnum == TaskActionEnum.nothing) {
      _getFromLocalDb();
    }  else if (_taskActionEnum == TaskActionEnum.done) {
      loadCompletedTasks();
    }
    notifyListeners();

  }

  get tasks => _tasks;

  void loadCompletedTasks() { 
    _getFromLocalDb();   
    _tasks = _tasks.where((w) => w.completed).toList();
    notifyListeners();
  }

  void searchTask(String searchText) {
    _getFromLocalDb();
    _tasks = _tasks.where((w)=> w.title.contains(searchText) || w.description.contains(searchText)).toList();
    notifyListeners();
  }

  TaskViewModel(){   
    _getFromLocalDb();
    notifyListeners();
  }

  void _getFromLocalDb() {
    _tasks = _taskBox.values.toList();    
  }

  Future<void> addTask(String title, String description) async {
    final int id = generateNewId;
    final Task task =
        Task(id: id, title: title, description: description, completed: false);
    
    await _taskBox.put(id, task);
    _getFromLocalDb();
    _tasks.insert(0, task);        
    notifyListeners();
  }  

  Future<void> updateTaskStatus(Task task) async {
    int idx = _tasks.indexWhere((i) => i.id == task.id);

    _tasks[idx].completed = !_tasks[idx].completed;
    await _taskBox.put(_tasks[idx].id, _tasks[idx]);    
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    await _taskBox.delete(task.id);
    _tasks.remove(task);
    notifyListeners();
  }

  Future<void> removeAllTask() async {
    await _taskBox.clear();
    _tasks.clear();
    notifyListeners();
  }

  int get generateNewId => _tasks.length + 1;
}