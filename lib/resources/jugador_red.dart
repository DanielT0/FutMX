import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/jugador.dart';

// Clase para gestionar (hacer operaciones CRUD) de datos en la base de datos, comunicandose con el servidor

class ProveedorJugador {
  Future<Jugador> obtenerJugadorCedula(String cedula) async {
    var admin;
    http.Response response = await http.post(
        'https://futmxpr.000webhostapp.com/app/getJugadorCedula.php',
        body: {"Cedula": cedula});
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (json.decode(response.body) == false) {
        admin = null;
      } else
        admin = Jugador.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future anadirJugador(String cedula) async {
    http.Response response = await http.post(
      'https://futmxpr.000webhostapp.com/app/insertJugador.php',
      body: {
        "Cedula": cedula,
      },
    );
    String body = response.body;
    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }
}
