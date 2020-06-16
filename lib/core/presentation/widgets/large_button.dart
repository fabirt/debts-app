import 'package:flutter/material.dart';

import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;

class LargeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const LargeButton({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = this.title ?? AppLocalizations.of(context).translate('save');
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: FlatButton(
          onPressed: onPressed,
          color: utils.Colors.brightGray,
          textColor: Colors.white,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
