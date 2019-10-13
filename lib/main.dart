import 'package:flutter/material.dart';
import 'package:debts_app/src/pages/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;


void main() {
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debty',
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Proximanova',
        primaryColor: utils.Colors.apple,
        scaffoldBackgroundColor: utils.Colors.athensGray,
        textTheme: TextTheme(
          body1: TextStyle(color: utils.Colors.brightGray)
        )
      ),
      builder: (BuildContext context, child) {
        return ScrollConfiguration(
          child: child,
          behavior: NeverOverScrollBehavior(),
        );
      },
    );
  }
}