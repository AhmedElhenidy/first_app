import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nobel/presentation/view/start_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [
      Locale("en",),Locale("ar"),
    ],
    fallbackLocale: Locale("en",),
    saveLocale: true,
    startLocale: Locale("ar"),
    child: StartScreen(),
  ),
  );
}









