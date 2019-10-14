import 'package:flutter/material.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/pages/debtors/debtors_page.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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

  void _initAnimations() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1400))
      ..addListener(() {
        setState(() {});
      });

    _scaleAnimation = Tween<double>(begin: 3.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.6, 1.0, curve: Curves.easeInOut)));
    _fabOffset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.6, 1.0, curve: Curves.easeInOut)));
    _cardsOffset = Tween<Offset>(begin: Offset(0.0, -0.20), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.2, 0.5, curve: Curves.easeInOut)));
    _cardsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.44, curve: Curves.easeInOut)));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = InheritedBloc.of(context);
    bloc.debtorsBloc.updateResume();

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
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    _buildOweMeCard(bloc),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
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
          margin: EdgeInsets.only(bottom: 30.0),
          child: AddButton(
            onPressed: () => _pushDebtorsPage(context),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildOweMeCard(InheritedBloc bloc) {
    return StreamBuilder(
      stream: bloc.debtorsBloc.resumeStream,
      initialData: DebtorsResume(),
      builder: (BuildContext context, AsyncSnapshot<DebtorsResume> snapshot){
        final label = snapshot.data.people == 1 ? 'persona' : 'personas';
        return DebtResumeCard(
          theme: DebtCardTheme.light,
          title: 'Me deben',
          value: utils.formatCurrency(snapshot.data.value),
          label: '${snapshot.data.people} $label',
          onTap: () => _pushDebtorsPage(context),
        );
      },
    );
  }

  Widget _buildIOweCard(InheritedBloc bloc) {
    return DebtResumeCard(
      theme: DebtCardTheme.dark,
      title: 'Debo',
      value: '\$ 0.00',
      label: 'a 0 personas',
      onTap: (){},
    );
  }

  void _pushDebtorsPage(BuildContext context) {
    Navigator.push(context, FadeRoute(page: DebtorsPage()));
  }

}
