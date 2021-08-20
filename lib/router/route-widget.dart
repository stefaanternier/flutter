
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/router/router-delegate-with-state.dart';
import 'package:youplay/router/youplay-route-information-parser.dart';

import '../localizations.dart';

class RouteWidget extends StatelessWidget {
  YouplayRouterDelegate routerDelegate;
  BookRouteInformationParser routeInformationParser;

  RouteWidget({required this.routeInformationParser,
    required  this.routerDelegate,
    Key? key})
      :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('nl'), const Locale('en')],
      debugShowCheckedModeBanner: false,
      title: AppConfig().appName!,
      theme: AppConfig().themeData,
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
      // home: new SplashScreen(),
      // initialRoute: '/',
      // onGenerateRoute: RouteConfiguration.onGenerateRoute,
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
    );
  }
}
