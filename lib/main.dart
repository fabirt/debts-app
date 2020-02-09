import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:debts_app/src/pages/index.dart';
import 'package:debts_app/src/widgets/index.dart';
import 'package:debts_app/src/bloc/inherited_bloc.dart';
import 'package:debts_app/src/utils/index.dart' as utils;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _supportedLocales = <Locale>[
    const Locale('es'),
  ];

  Locale _localeResolutionCallback(
    Locale locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (locale == null) {
      return supportedLocales.first;
    } else {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    }
  }

  Widget _builder(BuildContext context, Widget child) {
    return ScrollConfiguration(
      behavior: NeverOverScrollBehavior(),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InheritedBloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Debty',
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'Proximanova',
          primaryColor: const Color(0xFF00D3A5),
          primarySwatch: utils.Swatchs.greenSwatch,
          scaffoldBackgroundColor: utils.Colors.athensGray,
          textTheme: TextTheme(
            body1: TextStyle(color: utils.Colors.brightGray),
          ),
        ),
        supportedLocales: _supportedLocales,
        localeResolutionCallback: _localeResolutionCallback,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: _builder,
      ),
    );
  }
}
