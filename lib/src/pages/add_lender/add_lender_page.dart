import 'package:flutter/material.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class AddLenderPage extends StatefulWidget {
  @override
  _AddLenderPageState createState() => _AddLenderPageState();
}

class _AddLenderPageState extends State<AddLenderPage> {
  String name;

  @override
  void initState() {
    super.initState();
    name = '';
  }

  void _saveLender() async {
    final bloc = InheritedBloc.of(context);
    final lender = new Lender(name: name);
    await bloc.lendersBloc.addLender(lender);
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
      body: BlueHeaderContainer(
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
    return CustomAppBar(titleText: 'Agregar prestamista');
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
        onPressed: name.isEmpty ? null : _saveLender,
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
