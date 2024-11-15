import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remindly/model/task.dart';
import 'package:remindly/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  List<Task> get getTasks => tasks;
  String? error;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? date;
  String id = '';
  int remindertime = 30;
  DateTime selectedDate = DateTime.now();

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  Future<List<Task>> getUserTasks() async {
    // Call the server to get the tasks
    var data = await TaskServer.getTasks();
    if (data != null) {
      tasks = data['tasks'].map<Task>((e) => Task.fromJson(e)).toList();
    } else {
      error = 'Error getting tasks';
      return [];
    }
    // notifyListeners();
    return tasks;
  }

  Future<dynamic> createTask(String title, String description, String date,
      String id, int remindertime) async {
    var data =
        await TaskServer.createTask(title, description, date, id, remindertime);
    if (data != null) {
      tasks.add(Task.fromJson(data));
    } else {
      error = 'Error creating task';
    }
    clearControllers();
    clearDateIdRemindertime();
    notifyListeners();
  }

  Future<bool> updateTask(String id, String status) async {
    var data = await TaskServer.updatetask(id, status);
    if (data) {
      tasks.firstWhere((element) => element.sId == id).status = status;
    } else {
      error = 'Error updating task';
    }
    notifyListeners();
    return data;
  }

  //set date
  void setDate(String date) {
    this.date = date;
    notifyListeners();
  }

  void setselectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  //set id
  void setId(String id) {
    this.id = id;
    notifyListeners();
  }

  //set remindertime
  void setRemindertime(int remindertime) {
    this.remindertime = remindertime;
    notifyListeners();
  }

  //clear error
  void clearError() {
    error = null;
    notifyListeners();
  }

  //clear controllers
  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  //clear date and id and remindertime
  void clearDateIdRemindertime() {
    date = null;
    id = '';
    remindertime = 30;
    selectedDate = DateTime.now();
    notifyListeners();
  }
}
