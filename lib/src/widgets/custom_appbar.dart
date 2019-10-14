import 'package:flutter/material.dart';
import 'package:debts_app/src/utils/index.dart' as utils;
import 'package:debts_app/src/widgets/green_header_container.dart';

class CustomAppBar extends StatelessWidget {

  final String titleText;

  CustomAppBar({this.titleText});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                titleText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 10.0,)
          ],
        ),
      ),
    );
  }
}
