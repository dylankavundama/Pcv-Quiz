import 'package:quiz_app/about/about.dart';
import 'package:quiz_app/constants/color.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/livres/livres.dart';
import 'package:quiz_app/quiz/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/videos/viideoPage.dart';

class principalPage extends StatefulWidget {
  const principalPage({Key? key}) : super(key: key);

  @override
  _principalPageState createState() => _principalPageState();
}

class _principalPageState extends State<principalPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    MyApp(),
  Livres(),
    About(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          // elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: "Acceuil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_sharp),
              label: "Quiz",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.category),
            //   label: "Section",
            // ),

            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bible),
              label: "Livres",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.info),
              label: "Info",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
