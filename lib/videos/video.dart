import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/constants/color.dart';

class VideoListWidget extends StatefulWidget {
  const VideoListWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.description,
    required this.img,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String description;
  final String img;

  @override
  State<VideoListWidget> createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  @override
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

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: widget.screenHeight * 0.25,
        width: widget.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
         
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          width: constraints.minWidth,
                          height: constraints.minHeight * 0.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.img),
                                fit: BoxFit.cover),
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.playCircle,
                              color: kPrimaryColor,
                              size: 50,
                            ),
                          )),
                    ),

                               Text(
                      widget.description,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
