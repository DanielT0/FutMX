import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/jugador.dart';

// Clase para gestionar (hacer operaciones CRUD) de datos en la base de datos, comunicandose con el servidor

class ProveedorJugador {
  Future<Jugador> obtenerJugadorCedula(String cedula) async {
    var admin;
    http.Response response = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getJugadorCedula.php',
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

  Future<Jugador> obtenerJugadorNumero(String numero, String equipo) async {
    var jugador;
    http.Response response = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getJugadorNumeroEquipo.php',
        body: {
          "Numero": numero,
          "Equipo": equipo,
        });
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (json.decode(response.body) == false) {
        jugador = null;
      } else
        jugador = Jugador.fromJson(json.decode(response.body));
      return jugador;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<JugadorModel> obtenerJugadoresEquipo(String equipo) async {
    List<Jugador> _jugadores = [];
    var solicitudes;
    http.Response responseJugadoresEquipo = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getJugadoresEquipo.php',
        body: {
          "idEquipo": equipo,
        });
    int statusCode = responseJugadoresEquipo.statusCode;
    if (statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (responseJugadoresEquipo.body.length > 2) {
        solicitudes =
            JugadorModel.fromJson(json.decode(responseJugadoresEquipo.body));
      } else {
        solicitudes = new JugadorModel(_jugadores);
      }

      return solicitudes;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future anadirJugador(String cedula) async {
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertJugador.php',
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

   Future updateNumeroJugador(String id, String numero) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/updateNumeroJugador.php',
      body: {
        "Cedula": id,
        "Numero": numero,
      },
    );
    String body = response.body;
    print(body);
    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }
}
