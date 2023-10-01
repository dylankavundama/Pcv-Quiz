import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_notify/native_notify.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/principalPage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(
      3586,
      'c5ybwcdUrJia8mUPdq1JbX',
      'AAAAaa7LKD8:APA91bGP354OkO_y9aWvUjlmEIYfT-UQdgHXHVDM0f_1oH2sOQ0wlv2vNG3rBwI1XhEmVpKTLpGQaviIot3WdxLfbkbGWv7UJuq6PHX8OfGXtjGZSirQEpchnr4Dm42R1U9r9nPgpC8v',
      'resource://drawable/notification_icon');
  ;

  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pcv App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: principalPage(),
    );
  }
}
