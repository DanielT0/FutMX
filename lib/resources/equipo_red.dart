import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/equipo.dart';

class ProveedorEquipo {
  //Get All Todo items
  //Searches if query string was passed
  Future<Equipo> obtenerEquipoNombre(String nombre) async {
    var admin;
    http.Response response = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getEquipoNombre.php',
        body: {"Nombre": nombre});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (json.decode(response.body) == false) {
        admin = null;
      } else
        admin = Equipo.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Equipo> obtenerEquipoId(String id) async {
    var admin;
    http.Response response = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getEquipoId.php',
        body: {"idEquipo": id});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (json.decode(response.body) == false) {
        admin = null;
      } else
        admin = Equipo.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future updateNombreEquipo(String idEquipo, String newNombre) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertSolicitudActualizacionEquipo.php',
      body: {
        "idEquipo": idEquipo,
        "Nombre": newNombre,
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

  Future deleteEquipo(String idEquipo) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertSolicitudEliminacionEquipo.php',
      body: {
        "idEquipo": idEquipo,
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

  Future updateImageEquipo(String id, String image) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/updateImageEquipo.php',
      body: {
        "Equipo": id,
        "Image": image,
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
