import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:uni_links/uni_links.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/router/route-widget.container.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/store/store.dart';
import 'package:youplay/themes/kien.dart';

import 'config/login_config.dart';


StreamSubscription? _sub;
FirebaseAnalytics analytics = FirebaseAnalytics();


Future<Null> initUniLinks(Store<AppState> store) async {
  _sub = getLinksStream().listen((String? link) {
    if (link != null) {
      store.dispatch(new ParseLinkAction(link: link));
    }
  }, onError: (err) {});
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig().setAppConfig(
      appEnvironment: AppEnvironment.DIDOPROD,
      appName: 'your app name',
      description: '-',
      appBarIcon: 'graphics/icon/bibendocircleicon.png',
      baseUrl: 'yourpid.appspot.com',
      iosAppId: 'yourpid',
      androidAppId: 'yourpid',
      gcmSenderID: '289886738092',
      apiKey: 'yourkey',
      projectID: 'yourpid',
      storageBucket: 'gs://yourpid.appspot.com',
      themeData: didoTheme,
      analytics: analytics,
      customTheme: CustomTheme(),
      loginConfig: {
        "nl": LoginConfig(
            showDefaultLogin: true,
            defaultLoginName: "",
            defaultLoginPassword: ""
        ),
      });
  final store = await createStore();
  runApp(MyApp(store: store));
  FirebaseApp app = await Firebase.initializeApp();
  User? user = await FirebaseAuth.instance.currentUser;


  if (user != null) {
    String token = await user.getIdToken(true);
    store.dispatch(new CustomLoginSucceededAction(
        user.displayName, user.email, user.uid, user.isAnonymous));
  } else {
    if (AppConfig().themeData)
    store.dispatch(SetPage(page: PageType.intro));
  }

  store.dispatch(new LoadFeaturedGameAction());
  store.dispatch(new LoadRecentGamesAction());
  await initUniLinks(store);
  String? link = await getInitialLink();
  if (link != null) {
    store.dispatch(new ParseLinkAction(link: link));
  }
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: Center(
            child: RouteWidgetContainer(
              key: ValueKey('RouterWidgetContainer'),
            )
        ));
  }
}

