import 'package:atamnirbharapp/ui/screens/splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null) _auth.signInAnonymously();
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics _analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAnalytics>.value(value: _analytics),
          Provider<FirebaseAnalyticsObserver>.value(value: observer),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color.fromARGB(255, 0, 0, 136),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            navigatorObservers: [],
            home: SplashScreen()));
  }
}
