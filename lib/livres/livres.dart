import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/livres/HolySong.dart';
import 'package:share/share.dart';

class Livres extends StatefulWidget {
  const Livres({super.key});

  @override
  State<Livres> createState() => _LivresState();
}

class _LivresState extends State<Livres> {

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 202, 202),
      //  appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                        padding: const EdgeInsets.only(top: 18),
                        child: Text(
                          "Livres",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              Share.share(
                                  'https://play.google.com/store/apps/details?id=com.pcv');
                            },
                            icon: Icon(Icons.share)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('Principe divin'),
                subtitle: Text('Version française'),
                leading: CircleAvatar(
                  child: Text('FR'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath: 'assets/pdf/principe a couleur.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('Chant Sacrer'),
                subtitle: Text('Version française'),
                leading: CircleAvatar(
                  child: Text('FR'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath: 'assets/pdf/a.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('Chant Sacrer'),
                subtitle: Text('Version anglaise'),
                leading: CircleAvatar(
                  child: Text('EN'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath: 'assets/pdf/Holysong.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('Principedivin_extrait'),
                subtitle: Text('Version française'),
                leading: CircleAvatar(
                  child: Text('FR'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath: 'assets/pdf/Principedivin_extrait.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),
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
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('Principe divin'),
                subtitle: Text('Version anglaise'),
                leading: CircleAvatar(
                  child: Text('EN'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath: 'assets/pdf/principe1.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('Pensee de l\'Unification'),
                subtitle: Text('Version française'),
                leading: CircleAvatar(
                  child: Text('FR'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath: 'assets/pdf/PenseeUnification.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: 2 == 0 ? Colors.black : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text('principaux-serviteurs-de-Dieu'),
                subtitle: Text('Version française'),
                leading: CircleAvatar(
                  child: Text('FR'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFViewerFromAsset(
                        pdfAssetPath:
                            'assets/pdf/principaux-serviteurs-de-Dieu-LN1.pdf',
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
