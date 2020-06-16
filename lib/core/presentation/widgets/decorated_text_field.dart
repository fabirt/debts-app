import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:debts_app/core/utils/utils.dart' as utils;

class DecoratedTextField extends StatelessWidget {
  final bool autofocus;
  final String titleText;
  final String hintText;
  final String initialValue;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onFieldSubmitted;

  const DecoratedTextField({
    Key key,
    this.autofocus = true,
    @required this.titleText,
    @required this.hintText,
    this.initialValue,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          titleText,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        Theme(
          data: Theme.of(context).copyWith(
            primaryColor: utils.Colors.towerGray,
          ),
          child: TextFormField(
            autofocus: autofocus,
            controller: controller,
            focusNode: focusNode,
            initialValue: initialValue,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            cursorColor: utils.Colors.towerGray,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              counterText: null,
            ),
          ),
        )
      ],
    );
  }
}
