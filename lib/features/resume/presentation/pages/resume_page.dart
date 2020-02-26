import 'package:flutter/material.dart';

import 'package:debts_app/core/data/models/index.dart';
import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/widgets/index.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/router/index.dart';
import 'package:debts_app/core/utils/index.dart' as utils;

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<Offset> _cardsOffset;
  Animation<double> _cardsOpacity;
  Animation<Offset> _fabOffset;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = InheritedBloc.of(context);
    bloc.debtorsBloc.updateResume();
    bloc.lendersBloc.updateResume();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = Tween<double>(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _fabOffset = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );
    _cardsOffset = Tween<Offset>(
      begin: const Offset(0.0, -0.20),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );

    _cardsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.44, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InheritedBloc.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Background(
                scaleAnimation: _scaleAnimation,
              ),
              SafeArea(
                child: FadeTransition(
                  opacity: _cardsOpacity,
                  child: SlideTransition(
                    position: _cardsOffset,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: size.height * 0.05),
                        _buildOweMeCard(bloc),
                        SizedBox(height: size.height * 0.05),
                        _buildIOweCard(bloc),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: SlideTransition(
            position: _fabOffset,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child: AddButton(
                onPressed: () => _pushDebtorsPage(context),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _buildOweMeCard(InheritedBloc bloc) {
    return StreamBuilder<DebtorsResumeModel>(
      stream: bloc.debtorsBloc.resumeStream,
      initialData: DebtorsResumeModel(),
      builder: (context, snapshot) {
        final localizations = AppLocalizations.of(context);
        final label = snapshot.data.people == 1
            ? localizations.translate('person')
            : localizations.translate('people');
        return DebtResumeCard(
          theme: DebtCardTheme.light,
          title: localizations.translate('owe_me'),
          value: utils.formatCurrency(snapshot.data.value),
          label: '${snapshot.data.people} $label',
          onTap: () => _pushDebtorsPage(context),
        );
      },
    );
  }

  Widget _buildIOweCard(InheritedBloc bloc) {
    return StreamBuilder<DebtorsResumeModel>(
      stream: bloc.lendersBloc.resumeStream,
      initialData: DebtorsResumeModel(),
      builder: (context, snapshot) {
        final people = snapshot.data.people;
        final localizations = AppLocalizations.of(context);
        final label = snapshot.data.people == 1
            ? localizations.translate('person')
            : localizations.translate('people');
        return DebtResumeCard(
          theme: DebtCardTheme.dark,
          title: localizations.translate('i_owe'),
          value: utils.formatCurrency(snapshot.data.value),
          label: "${localizations.translate('to')} $people $label",
          onTap: () => _pushLendersPage(context),
        );
      },
    );
  }

  void _pushDebtorsPage(BuildContext context) {
    Router.navigator.pushNamed(Routes.debtors);
  }

  void _pushLendersPage(BuildContext context) {
    Router.navigator.pushNamed(Routes.lenders);
  }
}
