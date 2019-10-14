import 'package:flutter/material.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/models/index.dart';
import 'package:debts_app/src/pages/index.dart';
import 'package:debts_app/src/pages/debtors/widgets/debtor_card.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

class DebtorsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    final bloc = InheritedBloc.of(context);

    return Scaffold(
      body: GreenHeaderContainer(
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: RoundedShadowContainer(
                child: _buildContent(bloc),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: AddButton(
          onPressed: () => _addDebtor(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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
              margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Text(
                    'Me deben en total',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '\$ 200.000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(InheritedBloc bloc) {
    return StreamBuilder(
      stream: bloc.debtorsBloc.debtorsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Debtor>> snapshot){
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.isEmpty) return _buildEmptyState(); 
          return ListView.builder(
            itemCount: data.length,
            padding: EdgeInsets.only(bottom: 110.0, top: 20.0),
            itemBuilder: (BuildContext context, int i) {
              return DebtorCard(
                debtor: data[i],
                onTap: (Debtor d) {
                },
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
      message: 'No tienes deudas pendientes',
    );
  }


  void _addDebtor(BuildContext context) {
    Navigator.push(context, FadeRoute(page: AddDebtorPage()));
  }

}
