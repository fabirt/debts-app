import 'package:flutter/material.dart';
import 'package:debts_app/src/utils/index.dart' as utils;


class AddButton extends StatelessWidget {

  final Function onPressed;

  AddButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      height: 54.0,
      decoration: BoxDecoration(
        color: utils.Colors.brightGray,
        borderRadius: BorderRadius.circular(27.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 6.0),
            blurRadius: 6.0,
            spreadRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.07),
          ),
        ],
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Icon(Icons.add),
        textColor: Colors.white,
      ),
    );
  }
}