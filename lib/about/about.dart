import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/about/dia.dart';
import 'package:quiz_app/about/info.dart';
import 'package:quiz_app/about/policy.dart';
import 'package:quiz_app/about/timer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import '../constants/color.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final CountdownTimer _countdownTimer = CountdownTimer(10);
  //var _showWatchVideoButton = false;
  //var _coins = 0;
  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/4088353663'
      : 'ca-app-pub-7329797350611067/4088353663';
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
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.exit_to_app))
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
                        'https://play.google.com/store/apps/details?id=com.easykivu&pcampaignid=web_share');
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
                ListTile(
                  onTap: () {
                    launch(
                        'https://play.google.com/store/apps/details?id=com.easykivu&pcampaignid=web_share');
                  },
                  title: const Text(
                    'Mis a jour',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const Icon(
                    Icons.update,
                    color: Colors.black,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward,
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