import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/domain/entities/resume.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/router/router.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;

class DebtorsPage extends StatefulWidget {
  @override
  _DebtorsPageState createState() => _DebtorsPageState();
}

class _DebtorsPageState extends State<DebtorsPage>
    with SingleTickerProviderStateMixin {
  SlideInController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = SlideInController(vsync: this);
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = InheritedBloc.of(context);
    bloc.debtorsBloc.getDebtors();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = InheritedBloc.of(context);

    return Scaffold(
      body: GreenHeaderContainer(
        child: Column(
          children: <Widget>[
            _buildHeader(context, bloc),
            Expanded(
              child: SlideInTransition(
                controller: _animationController,
                child: RoundedShadowContainer(
                  child: _buildContent(bloc),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        child: AddButton(
          onPressed: () => _addDebtor(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader(BuildContext context, InheritedBloc bloc) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 34.0,
                vertical: 10.0,
              ),
              child: _buildHeaderDebt(bloc),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderDebt(InheritedBloc bloc) {
    return StreamBuilder(
      stream: bloc.debtorsBloc.resumeStream,
      initialData: Resume(),
      builder: (BuildContext context, AsyncSnapshot<Resume> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('owe_me_total'),
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 0.7),
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              utils.formatCurrency(snapshot.data.value),
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(InheritedBloc bloc) {
    return StreamBuilder(
      stream: bloc.debtorsBloc.debtorsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState();
          return ListView.builder(
            key: const Key('debtors-list'),
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return PersonCard(
                person: data[i],
                onTap: _onTapDebtor,
                onDismissed: (Person d) => _deleteDebtor(bloc, d),
              );
            },
          );
        } else {
          return _buildEmptyState();
        }
      },
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.sentiment_very_satisfied,
      message: AppLocalizations.of(context).translate('no_owe_me'),
    );
  }

  Future<void> _deleteDebtor(InheritedBloc bloc, Person debtor) async {
    await bloc.debtorsBloc.deleteDebtor(debtor);
  }

  void _onTapDebtor(Person debtor) {
    Router.navigator.pushNamed(Routes.singleDebtor, arguments: debtor);
  }

  void _addDebtor(BuildContext context) {
    Router.navigator.pushNamed(Routes.addDebtor);
  }
}
