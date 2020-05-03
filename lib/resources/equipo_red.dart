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
}
