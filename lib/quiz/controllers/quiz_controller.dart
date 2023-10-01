import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/quiz/models/question_model.dart';
import 'package:quiz_app/quiz/screens/result_screen/result_screen.dart';
import 'package:quiz_app/quiz/screens/welcome_screen.dart';

class QuizController extends GetxController {
  String name = '';
  //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
          "Où le Rev MOON a-t-il acquis les notions de paix selon ses observations?",
      answer: 2,
      options: [
        'Dans la prison de Heungnam',
        'Dans la maison de\nses parents',
        'Dans la nature',
        ' Sur le dos de son père'
      ],
    ),
    QuestionModel(
      id: 2,
      question:
          "Deux facteurs ont été source de guerre dans l’histoire humaine selon le Rev MOON",
      answer: 1,
      options: [
        'Famine et la richesse',
        'Le racisme et la religion',
        'Le pouvoir et l’argent',
        'La guerre'
      ],
    ),
    QuestionModel(
      id: 3,
      question:
          "Dans le poème de Notre Père, « la couronne de gloire », qu’est ce qu’il exprimait ?",
      answer: 2,
      options: [
        'La plainte sur sa mission',
        'Les péchés des hommes',
        'Les tourments de son cœur',
        'La gloire de Dieu'
      ],
    ),
    QuestionModel(
      id: 4,
      question: "Pourquoi Dieu a-t-il choisi Notre Père?",
      answer: 3,
      options: [
        'Son intelligence',
        'Son intelligence afin \n de comprendre sa mission',
        'Sa curiosité et sa capacité \n à prier avec ferveur',
        'Son opiniâtreté et\n son degré de cœur'
      ],
    ),
    QuestionModel(
      id: 5,
      question:
          "Comment s’appelait cette femme partant de la question précédente ?",
      answer: 3,
      options: ['Madame han', ' Madame Hong', ' Madame Moon', ' Madame Choe'],
    ),
    QuestionModel(
      id: 6,
      question: "Comment s’appelle le premier enfant de notre Père ?",
      answer: 1,
      options: ['Sung monn', 'Sung jin', 'Heung jin', 'sun jin'],
    ),
    QuestionModel(
      id: 7,
      question:
          "Dans sa rencontre avec le Président Kim Il-sung, quelle fut la plus longue conversation ?",
      answer: 3,
      options: [
        'Sur l’union entre les deux \n Corées',
        'Sur la chasse',
        ' Sur la pêche',
        'Sur les mets à base\n de pomme de terre'
      ],
    ),
    QuestionModel(
      id: 8,
      question: "A quel âge le Vrai Père avait-il rencontré la Vrai Mère ?",
      answer: 2,
      options: [
        'Pour restaurer EVE donc \n à l’âge de 16ans',
        'Pour avoir une EVE \n mure donc à l’âge de 21 ans',
        ' Très jeune à l’âge de 14 ans \n juste après sa première \nannée de collège',
        'A l’âge de 17 ans'
      ],
    ),
    QuestionModel(
      id: 9,
      question:
          "Le nom complet de la mère de la Vrai Mère en ses débuts dans l’église fut",
      answer: 1,
      options: [
        'Dae Mo Nim',
        'Pas de bonne réponse \n dans les assertions',
        ' Hong Mo Nim',
        'Soon-ae Nim '
      ],
    ),
    QuestionModel(
      id: 10,
      question:
          "Donnez la date complète de la date des fiançailles de nos Vrais Parents",
      answer: 1,
      options: [
        'Le 6 décembre 1960',
        'Le 27 mars 1960',
        'Le 6 janvier 1960',
        'Le 6 mars 1960'
      ],
    ),
    QuestionModel(
      id: 11,
      question: "Comment pouvons-nous connaître la nature du Dieu invisible ?",
      answer: 2,
      options: [
        'En observant l’esprit \n de l’Homme pécheur',
        'En observant les animaux',
        'En observant l’univers dont \n il est l’auteur',
        'En lisant sa parole'
      ],
    ),
    QuestionModel(
      id: 12,
      question:
          "Nous parlons de l’action de sujet-objet, ainsi que de la force. Des deux qui précède l’autre ?",
      answer: 3,
      options: [
        'La force',
        'Le partage',
        'Ni l’un ni l’autre',
        'L’action de sujet-objet'
      ],
    ),
    QuestionModel(
      id: 13,
      question:
          "En se basant sur la question précédente, qu’est-ce qui est à l’origine de tout ?",
      answer: 2,
      options: [
        'La force universelle',
        'La force première universelle',
        'Energie première universelle',
        'La base commune'
      ],
    ),
    QuestionModel(
      id: 14,
      question:
          "Si la conscience faisait défaut chez les personnes déchues, quelle serait laconséquence ?",
      answer: 1,
      options: [
        'Dieu n’agirait pas en\n l’Homme',
        'Toutes les réponses\n sont bonnes',
        'Dieu n’existerait pas en \nl’Homme',
        ' La providence divine de la \n restauration serait impossible'
      ],
    ),
    QuestionModel(
      id: 15,
      question:
          "Dans : « ce que j’ai appris sur la paix lorsque mon père me portait sur son dos », quel mot clé est le plus répétait ?",
      answer: 3,
      options: ['La famille', 'La religion', 'L’égoïsme', 'La paix'],
    ),
    QuestionModel(
      id: 16,
      question:
          "Le programme principe c'est ma vie concours a été initié, par qui, en quelle année et où ?",
      answer: 2,
      options: [
        'Doo kwon mwamba \n 2022,Lubumbashi',
        'Rang wan lubaka \n 2019,Lubumbashi ',
        'Rang wan lubaka \n 2015, Goma',
        'Doo chan JOSMAEL Burundi'
      ],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];

  bool _isPressed = false;

  bool get isPressed => _isPressed; //To check if the answer is pressed

  double _numberOfQuestion = 1;

  double get numberOfQuestion => _numberOfQuestion;

  int? _selectAnswer;

  int? get selectAnswer => _selectAnswer;

  int? _correctAnswer;

  int _countOfCorrectAnswers = 0;

  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  //map for check if the question has been answered
  final Map<int, bool> _questionIsAnswerd = {};

  //page view controller
  late PageController pageController;

  //timer
  Timer? _timer;

  final maxSec = 30;

  final RxInt _sec = 30.obs;

  RxInt get sec => _sec;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++; //corruge++
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => _timer!.cancel();
  //call when start again quiz
  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
