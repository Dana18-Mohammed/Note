import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/note_list.dart';

class SplashsScreen extends StatelessWidget {
  const SplashsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color mycolor = new Color(0xff1321E0);
    Color bckgroud = new Color(0xffCBF0f1);
    return SafeArea(
        child: Container(
      color: bckgroud,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'lib/images/home.jpg',
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                padding: const EdgeInsets.only(
                    left: 90, right: 90, top: 20, bottom: 20),
                color: mycolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NoteList()));
                })
          ],
        ),
      ),
    ));
  }
}
