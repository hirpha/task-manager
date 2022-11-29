import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../model/project.dart';

class ProjectDetailWidget extends StatelessWidget {
  Project project;
  ProjectDetailWidget({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                    Container(
                        padding: EdgeInsets.all(6),
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 11, 14, 20)),
                        child: Text(
                          "4 days left",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
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
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Text("AM"),
                            )),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Text("GD"),
                            )),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Text("LW"),
                            )),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: 0.7,
                      center: new Text(
                        "70.0%",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                          color: Colors.black45, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(project.endDate),
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
