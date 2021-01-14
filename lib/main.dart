import 'package:flutter/material.dart';
import 'package:qrscanner/src/pages/home.page.dart';
import 'package:qrscanner/src/pages/mapa.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRScanner',
      initialRoute: "home",
      debugShowCheckedModeBanner: false,
      routes: {
        "home": (_) => HomePage(),
        "mapa": (_) => MapaPage(),
      },
      theme: ThemeData(primaryColor: Colors.teal),
    );
  }
}
