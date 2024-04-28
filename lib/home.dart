import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/chant.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/quiz/main.dart';
import 'package:quiz_app/videos/viideoPage.dart';
import 'package:quiz_app/constants/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  BannerAd? _bannerAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7630097138'
      : 'ca-app-pub-7329797350611067/7630097138';
      

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppbarClass(),
            Stack(
              children: [
                if (_bannerAd != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: SizedBox(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 0)),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/b.jpg',
                        fit: BoxFit.cover,
                        height: h * 0.25,
                        width: w,
                      ),
                      Positioned(
                          top: h * 0.1,
                          width: w / 1,
                          child: const CircleAvatar(
                            radius: 33,
                            backgroundColor: kPrimaryLight,
                            child: Center(
                              child: Text("Quiz"),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 1)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PDFViewerFromAsset(
                          pdfAssetPath: 'assets/pdf/a.pdf',
                        )));
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/c.jpg',
                        fit: BoxFit.cover,
                        height: h * 0.25,
                        width: w,
                      ),
                      Positioned(
                        top: h * 0.1,
                        width: w / 1,
                        child: const CircleAvatar(
                          radius: 33,
                          backgroundColor: kPrimaryLight,
                          child: Center(
                            child: Text("Chants"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 1)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TabVideoPage()));
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/a.jpg',
                        fit: BoxFit.cover,
                        height: h * 0.25,
                        width: w,
                      ),
                      Positioned(
                        top: h * 0.1,
                        width: w / 1,
                        child: const CircleAvatar(
                          radius: 33,
                          backgroundColor: kPrimaryLight,
                          child: Center(
                            child: Text("Principe"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}

class AppbarClass extends StatelessWidget {
  const AppbarClass({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 150,
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
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Pcv\nLe Principe C'est Ma Vie",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () async {
                  const url =
                      'https://play.google.com/store/apps/details?id=com.pcv';
                  Share.share(
                      "Telecharger l'application PCV et apprenez d'avantage le principe divin\n$url");
                },
                icon: Icon(
                  Icons.share,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
