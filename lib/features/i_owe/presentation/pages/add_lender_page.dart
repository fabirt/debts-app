import 'package:flutter/material.dart';

import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/index.dart';
import 'package:debts_app/core/utils/index.dart' as utils;

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

  Future<void> _saveLender() async {
    final bloc = InheritedBloc.of(context);
    final lender = LenderModel(name: name);
    await bloc.lendersBloc.addLender(lender);
    Navigator.of(context).pop();
  }

  void _onTextChanged(String value) {
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
    return CustomAppBar(
      titleText: AppLocalizations.of(context).translate('add_person'),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FractionallySizedBox(widthFactor: 1.0),
          Text(
            AppLocalizations.of(context).translate('name'),
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          _buildTextField(),
          const Expanded(child: SizedBox()),
          _buildButton()
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: utils.Colors.towerGray),
      child: TextField(
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        cursorColor: utils.Colors.towerGray,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate('name_hint'),
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context).translate('save'),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }
}
