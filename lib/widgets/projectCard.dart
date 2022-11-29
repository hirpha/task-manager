import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/projectDetail.dart';

import '../model/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProjectDetail(
            project: project,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.projectName,
                        softWrap: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                      Container(
                          padding: EdgeInsets.all(6),
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 11, 14, 20)),
                          child: const Text(
                            "4 days left",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "Team Members",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text("AM"),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text("GD"),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text("LW"),
                              )),
                        ],
                      ),
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: 0.05,
                        center: const Text(
                          "5.0%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.purple,
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 5,
                          ),

                          // String formattedDate =
                          //             DateFormat('yyyy-MM-dd')
                          //                 .format(pickedDate);
                          Text(
                            "${DateFormat.yMMMMd().format(project.startDate)} - ",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            DateFormat.yMMMMd().format(project.endDate),
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
