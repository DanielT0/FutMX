import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/usuario.dart';

// Clase para gestionar (hacer operaciones CRUD) de datos en la base de datos, comunicandose con el servidor

class ProveedorUsuario {
    Future<Usuario> obtenerUsuarioCedula(String cedula) async {
      print(cedula);
    var admin;
    http.Response response = await http.post(
        'https://futmxpr.000webhostapp.com/app/getUsuarioCedula.php',
        body: {"Cedula": cedula});
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if(json.decode(response.body)==false){
         admin=null;
      }
      else
       admin = Usuario.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Usuario> obtenerUsuarioCorreo(String correo) async {
    
    var admin;
    http.Response response = await http.post(
        'https://futmxpr.000webhostapp.com/app/getUsuarioCorreo.php',
        body: {"Correo": correo});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(json.decode(response.body));
      if(json.decode(response.body)==false){
         admin=null;
      }
      else
       admin = Usuario.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}