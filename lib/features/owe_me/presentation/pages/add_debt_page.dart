import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;
import 'package:debts_app/features/owe_me/presentation/bloc/add_debt_bloc.dart';

class AddDebtPage extends StatefulWidget {
  final Person debtor;
  final Debt debt;

  const AddDebtPage({
    Key key,
    this.debt,
    @required this.debtor,
  }) : super(key: key);

  @override
  _AddDebtPageState createState() => _AddDebtPageState();
}

class _AddDebtPageState extends State<AddDebtPage> {
  final _focusNode = FocusNode();
  final AddDebtBloc _bloc = AddDebtBloc();

  @override
  void initState() {
    super.initState();
    if (widget.debt != null) {
      final value = utils.formatCurrency(widget.debt.value, '#,###');
      final description = widget.debt.description;
      _bloc.changeValue(value);
      _bloc.changeNote(description);
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    if (widget.debt != null) {
      _updateDebt();
    } else {
      _addDebt();
    }
  }

  Future<void> _addDebt() async {
    final bloc = InheritedBloc.of(context);
    final debt = Debt(
      parentId: widget.debtor.id,
      value: double.parse(_bloc.value),
      description: _bloc.note,
      date: DateTime.now().toString(),
    );
    await bloc.debtorsBloc.addDebt(debt, widget.debtor);
    Navigator.of(context).pop();
  }

  Future<void> _updateDebt() async {
    final bloc = InheritedBloc.of(context);
    final debt = Debt(
      id: widget.debt.id,
      parentId: widget.debtor.id,
      value: double.parse(_bloc.value),
      description: _bloc.note,
      date: widget.debt.date,
    );
    await bloc.debtorsBloc.updateDebt(debt, widget.debtor);
    Navigator.of(context).pop();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(child: _buildContent()),
                    ),
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
    final localizations = AppLocalizations.of(context);
    return CustomAppBar(
      titleText: widget.debt != null
          ? localizations.translate('edit_debt')
          : localizations.translate('add_debt'),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FractionallySizedBox(widthFactor: 1.0),
          Text(
            AppLocalizations.of(context).translate('value'),
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6.0),
          _buildValueTextField(),
          const SizedBox(height: 24.0),
          Text(
            AppLocalizations.of(context).translate('note'),
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6.0),
          _buildNoteTextField(),
        ],
      ),
    );
  }

  Widget _buildValueTextField() {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: utils.Colors.towerGray,
      ),
      child: TextFormField(
        autofocus: true,
        initialValue: _bloc.value,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        cursorColor: utils.Colors.towerGray,
        onChanged: _bloc.changeValue,
        maxLength: 11,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          utils.NumberFormatter(),
        ],
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate('value_hint'),
          counterText: null,
        ),
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_focusNode);
        },
      ),
    );
  }

  Widget _buildNoteTextField() {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: utils.Colors.towerGray,
      ),
      child: TextFormField(
        focusNode: _focusNode,
        initialValue: _bloc.note,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: utils.Colors.towerGray,
        onChanged: _bloc.changeNote,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate('note_hint'),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return StreamBuilder<bool>(
      stream: _bloc.validStream,
      builder: (context, snapshot) {
        return LargeButton(
          onPressed: snapshot.hasData && snapshot.data ? _onSavePressed : null,
        );
      },
    );
  }
}
