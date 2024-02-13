import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/about/info.dart';
import 'package:quiz_app/about/policy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../constants/color.dart';
class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;
//intertial pcv
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


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        // bottomLeft: Radius.circular(20),
                        // bottomRight: Radius.circular(20),
                        ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.5],
                      colors: [
                        Color(0xff886ff2),
                        Color(0xff6849ef),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Info",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 0)),
                ListTile(
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.pcv');
                  },
                  title: const Text(
                    'Share',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => info()),
                    );
                  },
                  title: const Text(
                    'A-propos',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    launch(
                        'https://play.google.com/store/apps/details?id=com.pcv');
                  },
                  title: const Text(
                    'Commentaire',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.add_comment,
                    color: Colors.black,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => policy()),
                    );
                  },
                  title: const Text(
                    'Confidentialite',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.key,
                    color: Colors.black,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: const Text(
                    'Developpeur',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => _onPressButon(context),
    );
  }

  Future<bool> _onPressButon(BuildContext context) async {
    bool? ext = await showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              title: const Text(
                'Quitter',
                style: TextStyle(color: kPrimaryColor),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Non",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Oui",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]);
        });

    return ext ?? false;
  }


}
