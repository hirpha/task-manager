import 'package:flutter/material.dart';

import '../model/project.dart';
import '../model/task.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _project = [];

  get project {
    return _project;
  }

//////////////////////////////////
////  ADDING NEW PROJECT

  void addProject(Project pro) {
    _project.add(pro);
    notifyListeners();
  }

//////////////////////////////////
//// RETURN ALL PROJECTS
  List<Project> displayProject() {
    print("project ${project}");
    return project;
  }

//////////////////////////////////
////  DISPLAY SPECIFIC DETAIL OF PROJECT

  Project displaySpecificProject(String projectName) {
    int index =
        _project.indexWhere((element) => element.projectName == projectName);
    Project project = _project.elementAt(index);
    return project;
  }

//////////////////////////////////
////  ADDING NEW TASK TO PROJECT

  void addTask(String projectName, Task task) {
    int index =
        _project.indexWhere((element) => element.projectName == projectName);
    Project oldProject = _project.elementAt(index);
    oldProject.tasks.add(task);
    _project[index] = oldProject;
    notifyListeners();
  }
}
