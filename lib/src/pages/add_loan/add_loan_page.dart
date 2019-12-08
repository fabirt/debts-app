import 'package:flutter/material.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class AddLoanPage extends StatefulWidget {
  final Lender lender;
  final Loan loan;

  AddLoanPage({
    Key key,
    this.loan,
    @required this.lender,
  }) : super(key: key);

  @override
  _AddLoanPageState createState() => _AddLoanPageState();
}

class _AddLoanPageState extends State<AddLoanPage> {
  String value;
  String description;
  bool valid;

  @override
  void initState() {
    super.initState();
    if (widget.loan != null) {
      value = widget.loan.value.toString();
      description = widget.loan.description;
      valid = true;
    } else {
      value = '';
      description = '';
      valid = false;
    }
  }

  void _onSavePressed() {
    if (widget.loan != null) {
      _updateLoan();
    } else {
      _addLoan();
    }
  }

  void _addLoan() async {
    final bloc = InheritedBloc.of(context);
    final loan = Loan(
      lenderId: widget.lender.id,
      value: double.parse(value),
      description: description,
      date: DateTime.now().toString(),
    );
    await bloc.lendersBloc.addLoan(loan, widget.lender);
    Navigator.pop(context);
  }
  
  void _updateLoan() async {
    final bloc = InheritedBloc.of(context);
    final loan = Loan(
      id: widget.loan.id,
      lenderId: widget.lender.id,
      value: double.parse(value),
      description: description,
      date: widget.loan.date,
    );
    await bloc.lendersBloc.updateLoan(loan, widget.lender);
    Navigator.pop(context);
  }

  void _validateForm() {
    if (value.isNotEmpty && description.isNotEmpty) {
      valid = true;
    } else {
      valid = false;
    }
  }

  void _onValueTextChanged(String text) {
    value = text;
    _validateForm();
    setState(() {});
  }

  void _onNoteTextChanged(String text) {
    description = text;
    _validateForm();
    setState(() {});
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SingleChildScrollView(child: _buildContent()),
                    _buildButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return CustomAppBar(
      titleText: widget.loan != null
        ? 'Editar deuda'
        : 'Agregar deuda',
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(28.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 1.0,
          ),
          Text(
            'Valor',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 6.0,
          ),
          _buildValueTextField(),
          SizedBox(
            height: 24.0,
          ),
          Text(
            'Nota',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 6.0,
          ),
          _buildNoteTextField(),
        ],
      ),
    );
  }

  Widget _buildValueTextField() {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: utils.Colors.towerGray),
      child: TextFormField(
        autofocus: true,
        initialValue: value,
        keyboardType: TextInputType.number,
        cursorColor: utils.Colors.towerGray,
        onChanged: _onValueTextChanged,
        decoration: InputDecoration(
          hintText: 'Escribe un valor',
        ),
      ),
    );
  }

  Widget _buildNoteTextField() {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: utils.Colors.towerGray),
      child: TextFormField(
        initialValue: description,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: utils.Colors.towerGray,
        onChanged: _onNoteTextChanged,
        decoration: InputDecoration(
          hintText: 'Deja una nota',
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: FlatButton(
          onPressed: valid ? _onSavePressed : null,
          color: utils.Colors.brightGray,
          textColor: Colors.white,
          child: FractionallySizedBox(
            widthFactor: 0.8,
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
      ),
    );
  }
}
