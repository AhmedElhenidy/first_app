import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nobel/presentation/view/start_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StartScreen());
}









