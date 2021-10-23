import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return AnnotatedRegion<SystemUiOverlayStyle>(
  //     value: SystemUiOverlayStyle.light,
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData.light(),
  //       home: HomeScreen(),
  //     ),
  //   );
  // }
}
