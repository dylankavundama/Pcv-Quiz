import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/quiz/screens/quiz_screen/quiz_screen.dart';
import '../controllers/quiz_controller.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
    Get.find<QuizController>().startTimer();
  }

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

    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  const Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/icons/play.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Column(
                      children: [
                        Text(
                          'Entré votre nom',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('pour demarrer le quiz',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    )),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Form(
                    key: _formkey,
                    child: GetBuilder<QuizController>(
                      init: Get.find<QuizController>(),
                      builder: (controller) => TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            labelText: 'Votre nom',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)))),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Le nom ne doit pas être vide';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? val) {
                          controller.name = val!.trim().toUpperCase();
                        },
                        onFieldSubmitted: (_) => _submit(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.034,
                  ),
                  TextButton.icon(
                    onPressed: () => _submit(context),
                    icon: Icon(Icons.arrow_forward),
                    label: Text(
                      'Appuyer',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                  Center(),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
