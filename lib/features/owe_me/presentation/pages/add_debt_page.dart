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
      _bloc.changeDate(widget.debt.date);
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
      date: _bloc.date,
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
      date: _bloc.date,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildValueTextField(),
          const SizedBox(height: 24.0),
          _buildNoteTextField(),
          const SizedBox(height: 32.0),
          DatePickerField(
            initialValue: _bloc.date,
            onChanged: _bloc.changeDate,
          ),
        ],
      ),
    );
  }

  Widget _buildValueTextField() {
    return DecoratedTextField(
      autofocus: true,
      initialValue: _bloc.value,
      titleText: AppLocalizations.of(context).translate('value'),
      hintText: AppLocalizations.of(context).translate('value_hint'),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      maxLength: 11,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        utils.NumberFormatter(),
      ],
      onChanged: _bloc.changeValue,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_focusNode);
      },
    );
  }

  Widget _buildNoteTextField() {
    return DecoratedTextField(
      autofocus: false,
      titleText: AppLocalizations.of(context).translate('note'),
      hintText: AppLocalizations.of(context).translate('note_hint'),
      initialValue: _bloc.note,
      focusNode: _focusNode,
      textCapitalization: TextCapitalization.sentences,
      onChanged: _bloc.changeNote,
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
