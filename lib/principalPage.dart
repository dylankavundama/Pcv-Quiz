import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/about/about.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/livres/livres.dart';
import 'package:quiz_app/quiz/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;
//intertial rj
  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/8200194655'
      : 'ca-app-pub-7329797350611067/8200194655';
  @override
  void _startNewGame() {
    setState(() => _counter = _gameLength);

    _loadAdd();
    _starTimer();
  }

  void _loadAdd() {
    InterstitialAd.load(
        adUnitId: _adUnitIdd,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                onAdClicked: (ad) {});

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void _starTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _counter--);

      if (_counter == 0) {
        _interstitialAd?.show();
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void go() {
    setState(() {
      _interstitialAd?.show();
    });
  }

  List<dynamic> _videos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    super.initState();
    _startNewGame();
  }

  Future<void> allVideo() async {
    _isLoading = true;
    setState(() {
      _isLoading = true;
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
