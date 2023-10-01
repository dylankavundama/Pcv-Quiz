import 'package:flutter/material.dart';

class info extends StatefulWidget {


  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Container(

              color: Color.fromARGB(15, 0, 0, 0),
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                "PCV (Le Principe c’est Ma Vie)\nEst une collection d’application, disposants d’une partie dédiée à l’apprentissage du principe divin, d’un jeu de QUIZ pour évaluer le niveau de connaissance du principe divin.\nDans ses versions actuelles nous avons ajouté le livre des chansons sacrées des saintes communautés des parents célestes.",
                  style: TextStyle(color: Colors.black,fontSize: 16),
                ),
              ),
            ),
            
          ],

          
        ),
      ),
    );
  }
}
