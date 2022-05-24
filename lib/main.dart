import 'package:flutter/material.dart';
import 'package:notes_app/SplashsScreen.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key key}) : super(key: key);

  Color bckgroud = new Color(0xffCBF0F8);
  Color mycolor = new Color(0xff1321E0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: bckgroud,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,

        ),

      ),
      home: const SplashsScreen(),
    );
  }
}
