import 'package:quiz_app/about/timer.dart';
import 'package:flutter/material.dart';

class AdDialog extends StatefulWidget {
  final VoidCallback showAd;

  const AdDialog({
    Key? key,
    required this.showAd,
  }) : super(key: key);

  @override
  AdDialogState createState() => AdDialogState();
}

class AdDialogState extends State<AdDialog> {
  final CountdownTimer _countdownTimer = CountdownTimer(1);

  @override
  void initState() {
    _countdownTimer.addListener(() => setState(() {
          if (_countdownTimer.isComplete) {
            Navigator.pop(context);
            widget.showAd();
          }
        }));
    _countdownTimer.start();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('');
  }

  @override
  void dispose() {
    _countdownTimer.dispose();
    super.dispose();
  }
}
