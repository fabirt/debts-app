import 'package:flutter/material.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class AddDebtorPage extends StatefulWidget {
  @override
  _AddDebtorPageState createState() => _AddDebtorPageState();
}

class _AddDebtorPageState extends State<AddDebtorPage> {
  String name;

  @override
  void initState() {
    super.initState();
    name = '';
  }

  void _saveDebtor() {
    Navigator.pop(context);
  }

  _onTextChanged(String value) {
    setState(() {
      name = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GreenHeaderContainer(
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: RoundedShadowContainer(
                child: _buildContent(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            Text(
              'Agregar deudor',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 1.0,
          ),
          Text(
            'Nombre',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10.0,
          ),
          _buildTextField(),
          Expanded(
            child: SizedBox(),
          ),
          _buildButton()
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Theme(
      data: ThemeData(primaryColor: utils.Colors.towerGray),
      child: TextField(
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        cursorColor: utils.Colors.towerGray,
        decoration: InputDecoration(
          hintText: 'Escribe un nombre',
          focusColor: Colors.red,
        ),
        onChanged: _onTextChanged,
      ),
    );
  }

  Widget _buildButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: FlatButton(
        onPressed: name.isEmpty ? null : _saveDebtor,
        color: utils.Colors.brightGray,
        textColor: Colors.white,
        child: FractionallySizedBox(
          widthFactor: 1.0,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Guardar',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }

}