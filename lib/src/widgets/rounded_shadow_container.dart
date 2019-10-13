import 'package:flutter/material.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class RoundedShadowContainer extends StatelessWidget {
  final Widget child;

  RoundedShadowContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        color: utils.Colors.athensGray,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, -8.0),
            blurRadius: 6.0,
            spreadRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.03),
          ),
        ],
      ),
      child: child,
    );
  }
}