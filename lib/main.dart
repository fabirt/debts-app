import 'package:flutter/material.dart';
import 'package:debts_app/src/pages/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

void main() {
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedBloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Debty',
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'Proximanova',
          primaryColor: const Color(0xFF00D3A5),
          primarySwatch: utils.Swatchs.greenSwatch,
          scaffoldBackgroundColor: utils.Colors.athensGray,
          textTheme: TextTheme(
            body1: TextStyle(color: utils.Colors.brightGray)
          ),
        ),
        builder: (BuildContext context, child) {
          return ScrollConfiguration(
            behavior: NeverOverScrollBehavior(),
            child: child,
          );
        },
      ),
    );
  }
}