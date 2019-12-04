import 'package:flutter/material.dart';
import 'package:mobile_py/route_generator.dart';

import 'package:mobile_py/src/view.dart' show FirstPage, SecondPage;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Initially display FirstPage
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
