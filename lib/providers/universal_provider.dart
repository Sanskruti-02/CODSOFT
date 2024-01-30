import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/task_widget.dart';
import '../models/data_model.dart';
import '../widgets/add_task_dialog_box.dart';
import '../widgets/edit_task_dialog_box.dart';

class UniversalProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  Color selectedColor = Colors.pink;

  DataModel? _dataModel;
  DataModel? get dataModel => _dataModel;

  List<TaskTile>? _completedTask;
  List<TaskTile>? get completedTask => _completedTask;

  List<TaskTile>? _incompleteTask;
  List<TaskTile>? get incompleteTask => _incompleteTask;

  int _currentScreenInd = 0;
  int get currentScreenInd => _currentScreenInd;

  set currentScreenInd(int index) {
    _currentScreenInd = index;
    notifyListeners();
  }

  void loadData() async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    String? dataModelString = preff.getString('dataModel');
    _dataModel = dataModelString != null
        ? DataModel.fromJson(jsonDecode(dataModelString))
        : DataModel(0, []);
    refreshLists();
    notifyListeners();
  }

  void refreshLists() {
    _completedTask = _dataModel!.tasks
        .where((task) => task.status == 'Completed')
        .toList()
        .map<TaskTile>((taskModel) =>
            TaskTile(key: ValueKey(taskModel.id), taskModel: taskModel))
        .toList();
    _incompleteTask = _dataModel!.tasks
        .where((task) => task.status == 'Incomplete')
        .toList()
        .map<TaskTile>((taskModel) =>
            TaskTile(key: ValueKey(taskModel.id), taskModel: taskModel))
        .toList();
  }

  void updateTaskStatus(int taskId, String newStatus) async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    _dataModel!.tasks[_dataModel!.tasks.indexWhere((task) => task.id == taskId)]
        .status = newStatus;
    await preff.setString('dataModel', jsonEncode(_dataModel!.toJson()));
    refreshLists();
    notifyListeners();
  }

  void deleteTask(int taskId) async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    _dataModel!.tasks
        .removeAt(_dataModel!.tasks.indexWhere((task) => task.id == taskId));
    await preff.setString('dataModel', jsonEncode(_dataModel!.toJson()));
    refreshLists();
    notifyListeners();
  }

  void addTask(TaskModel taskModel) async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    _dataModel!.tasks.insert(0, taskModel);
    _dataModel!.lastInd += 1;
    await preff.setString('dataModel', jsonEncode(_dataModel!.toJson()));
    if (_currentScreenInd == 1) {
      await Future.delayed(const Duration(milliseconds: 100));
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 150), curve: Curves.linear);
      _currentScreenInd = 0;
    }
    refreshLists();
    notifyListeners();
  }

  void updateTask(TaskModel taskModel) async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    _dataModel!.tasks[_dataModel!.tasks
        .indexWhere((task) => task.id == taskModel.id)] = taskModel;
    await preff.setString('dataModel', jsonEncode(_dataModel!.toJson()));
    refreshLists();
    notifyListeners();
  }

  void showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog(
          onAddPressed: (color, title, description) => addTask(
            TaskModel(
              id: _dataModel!.lastInd + 1,
              status: 'Incomplete',
              title: title,
              description: description,
              argb: [color.alpha, color.red, color.green, color.blue],
            ),
          ),
        );
      },
    );
  }

  void showEditTaskDialog(BuildContext context, TaskModel taskModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTaskDialog(
          taskModel: taskModel,
          onSavePressed: (model) => updateTask(model),
        );
      },
    );
  }
}
