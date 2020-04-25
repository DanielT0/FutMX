import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/partido.dart';

class ProveedorPartidos {
  //Get All Todo items
  //Searches if query string was passed
  Future<PartidoModel> obtenerProximosPartidos(String idEquipo) async {
    http.Response response = await http.post(
      'https://futmxpr.000webhostapp.com/app/getProximosPartidos.php',
      body: {"idEquipo": idEquipo},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var equipos = PartidoModel.fromJson(json.decode(response.body));

      return equipos;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<PartidoModel> obtenerAnterioresPartidos(String idEquipo) async {
    http.Response response = await http.post(
      'http://futmxpr.000webhostapp.com/app/getAnterioresPartidos.php',
      body: {"idEquipo": idEquipo},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var equipos = PartidoModel.fromJson(json.decode(response.body));

      return equipos;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
