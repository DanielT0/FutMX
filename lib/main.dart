import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ui/screens/home.dart';

import 'package:prueba_bd/providers/estadoGlobal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EstadoGlobal(),
      child: MaterialApp(
        title: 'Fut MX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home(),
      ),
    );
  }
}
