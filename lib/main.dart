import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../pages/home.dart';
import 'provider/projectProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>ProjectProvider()),
      ],
      child:  MaterialApp(
      title: 'Task manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.grey,
      ),
      home:  Home(),
    ));
  }
}
