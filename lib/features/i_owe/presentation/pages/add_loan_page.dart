import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:debts_app/core/domain/entities/debt.dart';
import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;
import 'package:debts_app/features/i_owe/presentation/bloc/add_loan_bloc.dart';

class AddLoanPage extends StatefulWidget {
  final Person lender;
  final Debt loan;

  const AddLoanPage({
    Key key,
    this.loan,
    @required this.lender,
  }) : super(key: key);

  @override
  _AddLoanPageState createState() => _AddLoanPageState();
}

class _AddLoanPageState extends State<AddLoanPage> {
  final AddLoanBloc _bloc = AddLoanBloc();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.loan != null) {
      final value = utils.formatCurrency(widget.loan.value, '#,###');
      final description = widget.loan.description;
      _bloc.changeValue(value);
      _bloc.changeNote(description);
    }
  }

  void _onSavePressed() {
    if (widget.loan != null) {
      _updateLoan();
    } else {
      _addLoan();
    }
  }

  Future<void> _addLoan() async {
    final bloc = InheritedBloc.of(context);
    final loan = Debt(
      parentId: widget.lender.id,
      value: double.parse(_bloc.value),
      description: _bloc.note,
      date: DateTime.now().toString(),
    );
    await bloc.lendersBloc.addLoan(loan, widget.lender);
    Navigator.of(context).pop();
  }

  Future<void> _updateLoan() async {
    final bloc = InheritedBloc.of(context);
    final loan = Debt(
      id: widget.loan.id,
      parentId: widget.lender.id,
      value: double.parse(_bloc.value),
      description: _bloc.note,
      date: widget.loan.date,
    );
    await bloc.lendersBloc.updateLoan(loan, widget.lender);
    Navigator.of(context).pop();
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
      titleText: widget.loan != null
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
        ],
      ),
    );
  }

  Widget _buildValueTextField() {
    return DecoratedTextField(
      autofocus: true,
      titleText: AppLocalizations.of(context).translate('value'),
      hintText: AppLocalizations.of(context).translate('value_hint'),
      initialValue: _bloc.value,
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
      titleText: AppLocalizations.of(context).translate('note'),
      hintText: AppLocalizations.of(context).translate('note_hint'),
      focusNode: _focusNode,
      initialValue: _bloc.note,
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
