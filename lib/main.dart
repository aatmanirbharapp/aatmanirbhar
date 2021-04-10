import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:atamnirbharapp/ui/screens/splash_screen.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null) {
      _prefs.setBool('loggedIn', true);
      _prefs.setBool(
          CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_SEARCH_PAGE, true);
      _prefs.setBool(
          CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_COMPANY_PAGE, true);
      _auth.signInAnonymously();
    }
    ;

    runApp(EasyLocalization(
      child: new MyApp(),
      supportedLocales: [Locale('en'), Locale('hi')],
      path: "assets/lang",
      saveLocale: true,
    ));
  });
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics _analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAnalytics>.value(value: MyApp._analytics),
          Provider<FirebaseAnalyticsObserver>.value(value: MyApp.observer),
        ],
        child: MaterialApp(
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: [const Locale('en'), const Locale('hi')],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color.fromARGB(255, 0, 0, 136),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            navigatorObservers: [],
            home: _auth.currentUser == null ? SplashScreen() : MyHomePage()));
  }
}
