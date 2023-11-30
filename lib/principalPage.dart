import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/about/about.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/livres/livres.dart';
import 'package:quiz_app/quiz/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cntAcceuil.dart';

class principalPage extends StatefulWidget {
  const principalPage({Key? key}) : super(key: key);

  @override
  _principalPageState createState() => _principalPageState();
}

class _principalPageState extends State<principalPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    MyApp(),
    Livres(),
    About(),
  ];
  @override
  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/5705114635'
      :'ca-app-pub-7329797350611067/5705114635';

  BannerAd? _bannerAd;
  final CountdownTimer _countdownTimer = CountdownTimer(10);
  RewardedAd? _rewardedAd;

  @override
  void dispose() {
    _rewardedAd?.dispose();
    _countdownTimer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _countdownTimer.addListener(() => setState(() {
          _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {});
        }));
    _startNewGame();
  }

  void _loadAd() {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          // elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: "Acceuil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_sharp),
              label: "Quiz",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bible),
              label: "Livres",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.info),
              label: "Info",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
