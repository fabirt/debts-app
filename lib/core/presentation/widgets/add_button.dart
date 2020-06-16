import 'package:flutter/material.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;

class AddButton extends StatelessWidget {
  final Function onPressed;

  const AddButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      height: 54.0,
      decoration: BoxDecoration(
        color: utils.Colors.brightGray,
        borderRadius: BorderRadius.circular(27.0),
        boxShadow: const [
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
        textColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
