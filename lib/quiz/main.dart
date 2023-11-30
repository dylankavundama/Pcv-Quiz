import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/quiz/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/quiz/screens/result_screen/result_screen.dart';
import 'package:quiz_app/quiz/screens/welcome_screen.dart';
import 'package:quiz_app/quiz/util/bindings_app.dart';

import '../about/cnt.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CountdownTimer _countdownTimer = CountdownTimer(10);
  //var _showWatchVideoButton = false;
  //var _coins = 0;
  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      //   ? 'ca-app-pub-7329797350611067/4088353663'
      // : 'ca-app-pub-7329797350611067/4088353663';

      ? 'ca-app-pub-7329797350611067/5705114635'
      : 'ca-app-pub-7329797350611067/5705114635';
//Id app ca-app-pub-3940256099942544~3347511713
  @override
  void initState() {
    super.initState();

    _countdownTimer.addListener(() => setState(() {
          _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            // ignore: avoid_print
          });
        }));
    _startNewGame();
  }

  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      title: 'PCV-QUIZ',
      home: WelcomeScreen(),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen()),
        GetPage(name: QuizScreen.routeName, page: () => QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () => ResultScreen()),
      ],
    );
  }

  void _loadAd() {
    setState(() {
      RewardedAd.load(
          adUnitId: _adUnitId,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          }, onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('RewardedAd failed to load: $error');
          }));
    });
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    _countdownTimer.dispose();
    super.dispose();
  }
}
