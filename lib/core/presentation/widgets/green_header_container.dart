import 'package:flutter/material.dart';
// import 'package:debts_app/core/utils/index.dart' as utils;

class GreenHeaderContainer extends StatelessWidget {
  final Widget child;

  const GreenHeaderContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.4, 0.3),
          colors: [Color(0xFF51F27D), Color(0xFF00D3A5)],
        ),
      ),
      child: child,
    );
  }
}
