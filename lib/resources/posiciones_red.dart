import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/posicion.dart';

class ProveedorPosiciones {
  //Get All Todo items
  //Searches if query string was passed
  Future<PosicionModel> obtenerPosiciones(String idLiga) async {
    http.Response response = await http.post(
      'https://futmxpr.000webhostapp.com/app/getPosicionesLiga.php',
      body: {"idLiga": idLiga},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var posiciones = PosicionModel.fromJson(json.decode(response.body));

      return posiciones;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}