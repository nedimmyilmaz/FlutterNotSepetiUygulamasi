import 'package:flutter/material.dart';
import 'package:flutterNotSepeti/screens/not_listesi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        darkTheme: ThemeData.dark(),
        home: NotListesi());
  }
}


