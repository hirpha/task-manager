import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../model/project.dart';
import '../provider/projectProvider.dart';
import '../widgets/projectDetailWidget.dart';
import '../model/task.dart';

class ProjectDetail extends StatefulWidget {
  Project project;
  ProjectDetail({
    required this.project,
  });

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
 
  Task? task;
  String assignedDeveloper = '';
  String developer = "Taddasa Jimaa";
  TextEditingController taskTitle = TextEditingController();

  //styling text
  TextStyle textStyle() {
    return const TextStyle(
        color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 20);
  }

  TextButton textButton(BuildContext ctx) {
    return TextButton(
      onPressed: () {
        setState(() {
          assignedDeveloper = "Abdisa Gurmuu";
        });
        Navigator.pop(ctx);
      },
      child: Row(
        children: const[
          CircleAvatar(
            child: Text("AM"),
          ),
          SizedBox(
            width: 5,
          ),
          Text("Abdisa Gurmu"),
        ],
      ),
    );
  }

  void createTask(ProjectProvider provider, String projectName) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    "Create Task",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Title",
                        style: textStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Note: Same code is applied for the TextFormField as well
                      Container(
                        height: 40,
                        child: TextFormField(
                          controller: taskTitle,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Assign developer",
                            style: textStyle(),
                          ),
                          DropdownButton<String>(
                            value: developer,
                            items: <String>[
                              'Taddasa Jimaa',
                              'Gurmu chala',
                              'Betelem moroda',
                              'Daniel chufa'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                developer = value.toString();
                              });
                              print(value);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              task = Task(
                                  title: taskTitle.text,
                                  assignedDeveloper: developer,
                                  status: "pending");
                              provider.addTask(projectName, task as Task);

                              Navigator.pop(context);
                            },
                            child: Text("Create")),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context, listen: true);
    Project pro =
        projectProvider.displaySpecificProject(widget.project.projectName);
    AppBar appBar = AppBar(
      title: Text(pro.projectName),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ],
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height * .968 -
            appBar.preferredSize.height,
        child: ListView(
          children: [
            ProjectDetailWidget(
              project: pro,
            ),
            if (pro.tasks.isEmpty)
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.center,
                  child: const ListTile(
                      leading: Icon(
                        Icons.info_outlined,
                        color: Colors.purple,
                      ),
                      title: Text("No task added yet"))),
            if (pro.tasks.isNotEmpty)
              Column(
                  children: (pro.tasks as List)
                      .map((element) => Card(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.pending,
                                  color: Colors.purple,
                                ),
                                title: Text(element.title.toString()),
                                trailing: const CircleAvatar(
                                  child: Text("AM"),
                                ),
                              ),
                            ),
                          ))
                      .toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Container(
          height: 50,
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text("Create and assign task"),
        ),
        shape: RoundedRectangleBorder(),
        onPressed: () => createTask(projectProvider, pro.projectName),
      ),
    );
  }
}
