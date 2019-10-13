import 'package:flutter/material.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  EmptyState({this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Color(0x5F00D3A5),
            size: 110.0,
          ),
          SizedBox(height: 12.0,),
          Text(
            message,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: utils.Colors.towerGray
            ),
          ),
        ],
      ),
    );
  }
}