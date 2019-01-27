import 'package:flutter/material.dart';
import 'dart:async';
import 'src/screens/login_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/detail_screen.dart';
import 'src/screens/scanning_screen.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter/services.dart';


void main() async {
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(details.exception, details.stack);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  bool optIn = true;
  if (optIn) {
    await FlutterCrashlytics().initialize();
  } else {
    // In this case Crashlytics won't send any reports.
    // Usually handling opt in/out is required by the Privacy Regulations
  }

  runZoned<Future<Null>>(() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(new MyApp());
    });
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    debugPrint(error.toString());
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: true);
  });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Check-in',
      theme: ThemeData(
        primarySwatch: Colors.red,
        canvasColor: Colors.transparent,
      ),
      home: LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/Home': return new MaterialPageRoute(
            builder: (BuildContext context) => new HomeScreen(),
            settings: settings,
          );
          case '/Detail': return new MaterialPageRoute(
            builder: (BuildContext context) => new DetailScreen(),
            settings: settings,
          );
          case '/Scanning': return new MaterialPageRoute(
            builder: (BuildContext context) => new ScanningScreen(),
            settings: settings,
          );
        }
        assert(false);
      },
    );
  }
}
