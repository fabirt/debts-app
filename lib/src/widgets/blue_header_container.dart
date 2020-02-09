import 'package:flutter/material.dart';
// import 'package:debts_app/src/utils/index.dart' as utils;

class BlueHeaderContainer extends StatelessWidget {
  final Widget child;

  const BlueHeaderContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.4, 0.3),
          colors: [Color(0xFF3C8BD9), Color(0xFF3E2E92)],
        ),
      ),
      child: child,
    );
  }
}
