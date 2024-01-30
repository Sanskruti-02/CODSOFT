import 'package:todo/models/task_model.dart';

class DataModel {
  int lastInd;
  List<TaskModel> tasks;

  DataModel(this.lastInd, this.tasks);

  Map<String, dynamic> toJson() {
    return {
      'lastInd': lastInd,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  factory DataModel.fromJson(Map<String, dynamic> json) {
    var taskList = (json['tasks'] as List<dynamic>)
        .map((taskJson) => TaskModel.fromJson(taskJson))
        .toList();

    return DataModel(
      json['lastInd'],
      taskList,
    );
  }
}
