import 'package:flutter/material.dart';
import 'package:prototype_bjb/screens/splash_screen.dart';
import 'package:prototype_bjb/utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF0093DD, kcolorPrimary),
      ),
      home: SplashScreen(),
    );
  }
}

