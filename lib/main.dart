import 'package:flutter/material.dart';
import 'package:my_schedule/confs/routes.dart';
import 'package:my_schedule/list_classes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routesOfApp,
      initialRoute: HOME_PAGE,
      debugShowCheckedModeBanner: false,
    );
  }
}
