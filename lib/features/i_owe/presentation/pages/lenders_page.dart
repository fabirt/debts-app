import 'package:flutter/material.dart';

import 'package:debts_app/core/domain/entities/person.dart';
import 'package:debts_app/core/domain/entities/resume.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/widgets/widgets.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/router/router.dart';
import 'package:debts_app/core/utils/utils.dart' as utils;

class LendersPage extends StatefulWidget {
  @override
  _LendersPageState createState() => _LendersPageState();
}

class _LendersPageState extends State<LendersPage>
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
    bloc.lendersBloc.getLenders();
    bloc.lendersBloc.updateResume();
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
      body: BlueHeaderContainer(
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
          onPressed: () => _addLender(context),
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
            SizedBox(width: double.infinity),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
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
      stream: bloc.lendersBloc.resumeStream,
      initialData: Resume(),
      builder: (BuildContext context, AsyncSnapshot<Resume> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('i_owe_total'),
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
      stream: bloc.lendersBloc.lendersStream,
      builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState(context);
          return ListView.builder(
            key: const Key('lenders-list'),
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return PersonCard(
                person: data[i],
                onTap: _onTapLender,
                onDismissed: (Person l) => _deleteLender(bloc, l),
              );
            },
          );
        } else {
          return _buildEmptyState(context);
        }
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyState(
      icon: Icons.sentiment_very_satisfied,
      message: AppLocalizations.of(context).translate('no_i_owe'),
    );
  }

  Future<void> _deleteLender(InheritedBloc bloc, Person lender) async {
    await bloc.lendersBloc.deleteLender(lender);
  }

  void _onTapLender(Person lender) {
    Router.navigator.pushNamed(Routes.singleLender, arguments: lender);
  }

  void _addLender(BuildContext context) {
    Router.navigator.pushNamed(Routes.addLender);
  }
}
