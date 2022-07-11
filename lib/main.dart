import 'package:flutter/material.dart';
import 'pages/all.dart';

void main(List<String> args) {
  runApp(OmegaNotes());
}

class OmegaNotes extends StatelessWidget {
  const OmegaNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primaryColor: Color(0xFF880E4F)),
      routes: {
        HomePage.routeName: (context) => HomePage() 
      },
    );
  }
}