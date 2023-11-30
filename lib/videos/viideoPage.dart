import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/about/dia.dart';
import 'package:quiz_app/about/timer.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'videoJson.dart';
import 'video.dart';

class TabVideoPage extends StatefulWidget {
  const TabVideoPage({Key? key}) : super(key: key);

  @override
  State<TabVideoPage> createState() => _TabVideoPageState();
}

class _TabVideoPageState extends State<TabVideoPage> {
//  pour liste d'une maniere ascendante
  List<Video> _videos = [];
  @override
  void initState() {
    super.initState();

    videos.sort((a, b) => b.idVideo.compareTo(a.idVideo));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: videos
              .map(
                (e) => GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return VideoDisplayPage(
                              urlVideo: e.urlVideo,
                              id: e.description,
                            );
                          });
                    },
                    child: VideoListWidget(
                        screenHeight: screenHeight,
                        description: e.description,
                        img: e.img,
                        screenWidth: screenWidth)),
              )
              .toList(),
        ),
      ),
    );
  }
}

class VideoDisplayPage extends StatefulWidget {
  const VideoDisplayPage({required this.id, required this.urlVideo, Key? key})
      : super(key: key);
  final String urlVideo;
  final String id;

  @override
  State<VideoDisplayPage> createState() => _VideoDisplayPageState();
}

class _VideoDisplayPageState extends State<VideoDisplayPage> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();
    String url = widget.urlVideo;
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: true));
    // videoList.shuffle();

    _countdownTimer.addListener(() => setState(() {
          if (_countdownTimer.isComplete) {
            showDialog(
                context: context,
                builder: (context) => AdDialog(showAd: () {
                      _showAdCallback();
                    }));
            _coins += 1;
          }
        }));
    _startNewGame();

        super.initState();
    _loadAd();
  }

  @override
  void deactivate() {
    controller.pause();
  }

  final CountdownTimer _countdownTimer = CountdownTimer(1);
  var _coins = 0;
  RewardedInterstitialAd? _rewardedInterstitialAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/6682586161'
      : 'ca-app-pub-7329797350611067/6682586161';

  void _startNewGame() {
    _loadAd();
    _countdownTimer.start();
  }

  void _showAdCallback() {
    _rewardedInterstitialAd?.show(
        onUserEarnedReward: (AdWithoutView view, RewardItem rewardItem) {
      // ignore: avoid_print
      print('Reward amount: ${rewardItem.amount}');
      setState(() => _coins += rewardItem.amount.toInt());
    });
  }


  @override
  BannerAd? _bannerAd;

  final String _adUnitIdd = Platform.isAndroid
   !//   ? 'ca-app-pub-7329797350611067/7630097138'
      //: 'ca-app-pub-7329797350611067/7630097138';
      ? ''
      :'';


  void _loadAd() async {

  RewardedInterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback:
            RewardedInterstitialAdLoadCallback(onAdLoaded: (ad) {
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
          _rewardedInterstitialAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('RewardedInterstitialAd failed to load: $error');
        }));

    BannerAd(
      adUnitId: _adUnitIdd,
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
 
     _rewardedInterstitialAd?.dispose();
    _countdownTimer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeftLong,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                ),
                Text(
                  "Lecture video",
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              height: screenHeight * 0.6,
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: false,
              ),
            ),
          ),
          Container(
            width: screenWidth,
            color: kPrimaryColor,
            child: Text(
              widget.id,
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Center(
              child: TextButton(
                  onPressed: () {
                    _startNewGame();
                  },
                  child: Text("LAISSER UN COMMENTER"),),),

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
        ],
      ),
    );
  }




}
