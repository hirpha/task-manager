import 'package:task_manager/model/task.dart';

class Project {
  String projectName;
  DateTime startDate;
  DateTime endDate;
  int progress;
  List<Task> tasks = [];
  Project(
      {required this.projectName,
      required this.startDate,
      required this.progress,
      required this.endDate,
      
      });
}
