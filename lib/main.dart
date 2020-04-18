import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ui/screens/home.dart';

import 'package:prueba_bd/providers/estadoGlobal.dart';

void main() => runApp(MyApp());

/**
 * Y aquí inicia todo... Manejaremos los modelos bloc(para un correcto manejo de datos) y provider (para almacenar los datos del usuario que inicia sesión)
 * Pequeño tour: En el panel de la izquierda pueden ver varias carpetas dentro del archivo lib (que es donde programamos)
 * blocs tendrá los bloc que manejan el estado de la aplicación (controller), que usa a los archivos red (resources)
 * para obtener los datos, models representa a los objetos que manejamos en la app, y ui a los elementos que se presentan al usuario
 * En providers está el estado global, que manejará las variables del usuario que son usadas en distintas interfaces 
*/
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
        home: Home(),                 // Iniciamos con Home (ui/screens/home.dart)
      ),
    );
  }
}
