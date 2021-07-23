import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:uni_links/uni_links.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/router/route-widget.dart';
import 'package:youplay/router/router-delegate-with-state.dart';
import 'package:youplay/router/youplay-route-information-parser.dart';
import 'package:youplay/router/youplay-route-path.dart';
import 'package:youplay/screens/pages/game_landing_page.dart';
import 'package:youplay/screens/pages/game_landing_page.route.dart';
import 'package:youplay/screens/pages/home_page.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/store.dart';
import 'package:youplay/themes/kien.dart';

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
