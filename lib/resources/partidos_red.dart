import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/partido.dart';

class ProveedorPartidos {
  //Get All Todo items
  //Searches if query string was passed
  Future<PartidoModel> obtenerProximosPartidos(String idEquipo) async {
    List<Partido> _partidos = [];
    var equipos ;
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/getProximosPartidos.php',
      body: {"idEquipo": idEquipo},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (response.body.length>2) {
        equipos = PartidoModel.fromJson(json.decode(response.body));
      } else {
        equipos = new PartidoModel(_partidos);
      }

      return equipos;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<PartidoModel> obtenerAnterioresPartidos(String idEquipo) async {
    http.Response response = await http.post(
      'http://futbolmx1.000webhostapp.com/app/getAnterioresPartidos.php',
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

  Future prepararDatosPago(String partido, String equipo, String cuota) async {
    http.Response responseUsuarioInscrito = await http
        .post('https://futbolmx1.000webhostapp.com/pagos/cuota.php', body: {
      "Partido": partido,
      "Total": cuota,
      "Equipo" : equipo,
    });
    int statusCode = responseUsuarioInscrito.statusCode;
    var data = jsonDecode(responseUsuarioInscrito.body);
    var respuestaUsuario = data.toString();
    if (statusCode == 200) {
      return respuestaUsuario;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }
}
