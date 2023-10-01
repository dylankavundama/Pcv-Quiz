import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/quiz/controllers/quiz_controller.dart';

import '../../constants/constants.dart';

class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.sec.value / 30),
              color: KPrimaryColor,
              backgroundColor: Colors.black,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.sec.value}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
