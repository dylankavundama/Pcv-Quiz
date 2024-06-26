import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/quiz/controllers/quiz_controller.dart';
import 'package:quiz_app/quiz/widgets/custom_button.dart';

import '../../../constants/constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Center(
          child: GetBuilder<QuizController>(
            init: Get.find<QuizController>(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Félicitation',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  controller.name,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: kPrimaryColor,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Votre score est de',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '${controller.scoreResult.round()} /100',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: kPrimaryColor,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(

                    onPressed: () => controller.startAgain(),
                    text: 'retour'),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
