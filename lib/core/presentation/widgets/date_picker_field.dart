import 'package:flutter/material.dart';

import 'package:debts_app/core/utils/utils.dart' as utils;

class DatePickerField extends StatefulWidget {
  final String initialValue;
  final ThemeData dialogTheme;
  final ValueChanged<String> onChanged;

  const DatePickerField({
    Key key,
    this.initialValue,
    this.dialogTheme,
    this.onChanged,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime _selectedDate;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialValue == null) {
      _controller.text = 'Hoy';
      _selectedDate = DateTime.now();
    } else {
      final date = DateTime.tryParse(widget.initialValue);
      _selectedDate = date;
      _formatTextFieldValue(date);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (widget.onChanged != null) {
      widget.onChanged(_selectedDate.toIso8601String());
    }
  }

  void _formatTextFieldValue(DateTime date) {
    if (DateTime.now().difference(date).inDays < 1) {
      _controller.text = 'Hoy';
    } else {
      _controller.text = utils.formatDate(date);
    }
  }

  Future<void> _selectDate() async {
    FocusScope.of(context).unfocus();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: 'Seleccionar fecha'.toUpperCase(),
      errorFormatText: 'Fecha inválida.',
      fieldLabelText: 'Ingresar Fecha',
      builder: (context, child) {
        return Theme(
          data: widget.dialogTheme ?? Theme.of(context),
          child: child,
        );
      },
    );
    if (date != null) {
      _selectedDate = date;
      _formatTextFieldValue(date);
      _onChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Fecha',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        Theme(
          data: Theme.of(context).copyWith(
            primaryColor: utils.Colors.towerGray,
          ),
          child: InkWell(
            onTap: _selectDate,
            child: TextField(
              enabled: false,
              controller: _controller,
              cursorColor: utils.Colors.towerGray,
              decoration: const InputDecoration(
                hintText: 'Seleccionar fecha',
                counterText: null,
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
