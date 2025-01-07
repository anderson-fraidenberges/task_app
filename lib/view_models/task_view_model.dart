import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_app/enums/task_action_enum.dart';
import 'package:task_app/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskViewModel extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');
  List<Task> _tasks = [];  
  TaskActionEnum _taskActionEnum = TaskActionEnum.nothing; 
  int pageSize = 10;    
  int length = 0;

  void incrementPageSize() {
     pageSize += 10;
     loadTasks(); 
  }

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
    _tasks = _taskBox.values.where((w) => w.completed).take(pageSize).toList();
    notifyListeners();
  }

  void searchTask(String searchText) {    
    _tasks =  _taskBox.values.where((w)=> w.title.contains(searchText) || w.description.contains(searchText)).take(pageSize).toList();
    notifyListeners();
  }

  TaskViewModel(){   
    _getFromLocalDb();     
    notifyListeners();
  }

  void _getFromLocalDb() {   
    length = _taskBox.values.toList().length;
    _tasks.clear();
    _tasks = _taskBox.values.take(pageSize).toList();    
  }

  Future<void> addTask(String title, String description) async {
    final String guid = generateNewGuid();
    final Task task =
        Task(id: guid, title: title, description: description, completed: false);
    
    await _taskBox.put(guid, task);
    await _taskBox.flush();
    _getFromLocalDb();            
    notifyListeners();
  }  

  Future<void> updateTaskStatus(Task task) async {
    int idx = _tasks.indexWhere((i) => i.id == task.id);

    _tasks[idx].completed = !_tasks[idx].completed;
    await _taskBox.put(_tasks[idx].id, _tasks[idx]);  
    await _taskBox.flush();  
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    await _taskBox.delete(task.id);
    length = _taskBox.values.toList().length;
    _tasks.remove(task);
    notifyListeners();
  }

  Future<void> removeAllTask() async {
    
    for (var task in _taskBox.values.where((w)=> w.completed).toList()) {
        await _taskBox.delete(task.id);              
    }    
    await _taskBox.flush();
     _getFromLocalDb();
    notifyListeners();
  }

  String generateNewGuid() { 
    var uuid = const Uuid();
    return uuid.v4();   
  }
}