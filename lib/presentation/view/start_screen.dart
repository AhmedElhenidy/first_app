import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nobel/presentation/view/home_page_screen.dart';
import 'package:nobel/presentation/view/sign_in_screen.dart';

class StartScreen extends StatelessWidget{
  @override
  Widget build (BuildContext  context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context,widget){
        return Directionality(textDirection: TextDirection.ltr, child: widget!);
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffA71E27),
        ),
        scaffoldBackgroundColor: Colors.black
      ),
      home:FirebaseAuth.instance.currentUser==null?SignInScreen():HomePageScreen(),
    );
  }
}