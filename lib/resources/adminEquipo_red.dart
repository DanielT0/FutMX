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
        'https://futmxpr.000webhostapp.com/app/getAdminEquipoCedula.php',
        body: {"Cedula": cedula});
    print(response.body);
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
}
