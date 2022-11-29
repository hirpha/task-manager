import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/model/project.dart';
import 'package:task_manager/provider/projectProvider.dart';
import 'package:task_manager/widgets/projectCard.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Styling tetx
  TextStyle textStyle() {
    return const TextStyle(
        color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 20);
  }

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController projectTitle = TextEditingController();

  @override
  void initState() {
    //set the initial value of text field
    projectTitle.text = "";
    startDate.text = "";
    endDate.text = "";
    super.initState();
  }

//////////////////////////////////
////  ADDING START DATE METHOD

  void addStartDate(BuildContext ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        startDate.text = formattedDate; //set output date to TextField value.
      });
    } else {
      setState(() {});
    }
  }


//////////////////////////////////
////  ADDING END DATE METHOD

  void addEndDate(BuildContext ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); 
      setState(() {
        endDate.text = formattedDate; 
      });
    } else {}
  }


//////////////////////////////////
////  ADDING NEW PROEJECT METHOD

  void addProject(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(ctx).size.height * 0.65,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    "Add Project",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Project Title",
                        style: textStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Note: Same code is applied for the TextFormField as well
                      Container(
                        height: 40,
                        child: TextFormField(
                          controller: projectTitle,
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

                      Text(
                        "Start Date",
                        style: textStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: startDate,
                        readOnly: true,
                        onTap: () => addStartDate(ctx),
                        decoration: const InputDecoration(
                          prefixIcon:
                              Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Start Date" //label text of field
                          ,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                        ),
                      ),
                     const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "End Date",
                        style: textStyle(),
                      ),
                    const  SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: endDate,
                        readOnly: true,
                        onTap: () => addEndDate(ctx),
                        decoration: const InputDecoration(
                          prefixIcon:
                              Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter End Date" //label text of field
                          ,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(ctx).size.width * 1,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Project project = Project(
                                projectName: projectTitle.text,
                                startDate: DateTime.parse(startDate.text),
                                progress: 0,
                                endDate: DateTime.parse(endDate.text),
                              );
                              setState(() {
                                projectTitle.text = "";
                              });
                              Provider.of<ProjectProvider>(context,
                                      listen: false)
                                  .addProject(project);

                              Navigator.pop(context);
                            },
                            child: Text("Done")),
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
    final addedProject = projectProvider.displayProject();
    AppBar appBar = AppBar(
      actions: [
        TextButton.icon(
            onPressed: () => addProject(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              "Add Project",
              style: TextStyle(color: Colors.white),
            ))
      ],
      title: Text("Task manager"),
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: appBar,
      body: Container(
        height:
            MediaQuery.of(context).size.height - appBar.preferredSize.height,
        child: ListView(
          children: [
            if (addedProject.isEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text(
                  "Manage your Team and Everything with Task manager Application",
                  style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              ),
            if (addedProject.isEmpty)
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .25),
                child: const ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.purple,
                    ),
                    title: Text(
                        "Add Project to Task Manager Application to manage your project and team")),
              ),
            if (addedProject.isNotEmpty)
              Container(
                margin: EdgeInsets.only(left: 10, top: 10, right: 150),
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Ongoing Projects",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            if (addedProject.isNotEmpty)
              Column(
                children: addedProject.map((element) {
                  return ProjectCard(
                    project: element,
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addProject(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
