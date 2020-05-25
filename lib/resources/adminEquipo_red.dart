import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/adminEquipo.dart';

class ProveedorAdministradorEquipo {
  //Get All Todo items
  //Searches if query string was passed
  Future<AdministradorEquipo> obtenerAdminCedula(String cedula) async {
    var admin;
    http.Response response = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getAdminEquipoCedula.php',
        body: {"Cedula": cedula});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if(json.decode(response.body)==false){
         admin=null;
      }
      else
       admin = AdministradorEquipo.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<AdministradorEquipo> obtenerAdminCorreo(String correo) async {
    var admin;
    http.Response response = await http.post(
        'https://futbolmx1.000webhostapp.com/app/getAdminEquipoCorreo.php',
        body: {"Correo": correo});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(json.decode(response.body));
      if(json.decode(response.body)==false){
         admin=null;
      }
      else
       admin = AdministradorEquipo.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future actualizarAdministradorEquipo(String id, AdministradorEquipo adminEquipo) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertSolicitudAdminEquipo.php',
      body: {
        "Antig": id,
        "Cedula": adminEquipo.cedula,
        "Nombre": adminEquipo.nombre,
        "Correo": adminEquipo.correo,
        "Contrasena": adminEquipo.contrasena
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
