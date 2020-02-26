import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:debts_app/core/locale/app_localizations.dart';
import 'package:debts_app/core/presentation/widgets/index.dart';
import 'package:debts_app/core/presentation/bloc/inherited_bloc.dart';
import 'package:debts_app/core/utils/index.dart' as utils;
import 'package:debts_app/features/resume/presentation/pages/resume_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _supportedLocales = <Locale>[
    const Locale('es'),
    const Locale('en'),
  ];

  Locale _localeResolutionCallback(
    Locale locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (locale == null) {
      Intl.defaultLocale = supportedLocales.first.toString();
      return supportedLocales.first;
    } else {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          Intl.defaultLocale = supportedLocale.toString();
          return supportedLocale;
        }
      }
      Intl.defaultLocale = supportedLocales.first.toString();
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
        home: ResumePage(),
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
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: _builder,
      ),
    );
  }
}
