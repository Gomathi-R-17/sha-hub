import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rcc_project/screens/welcome_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Core());
}

class Core extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lava();
  }
}

class Lava extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shara Hunters",
      home: Home(),
      theme: ThemeData(fontFamily: 'Noto Sans'),
      debugShowCheckedModeBanner: false,
    );
  }
}
