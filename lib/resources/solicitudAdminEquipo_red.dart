import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:prueba_bd/models/solicitudAdminEquipo.dart';

class ProveedorSolicitudAdminEquipo {
  Future anadirSolicitudAdministradorEquipo(SolicitudAdministradorEquipo adminEquipo) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertSolicitudAdminEquipo.php',
      body: {
        "Cedula": adminEquipo.cedula,
        "Nombre": adminEquipo.nombre,
        "Correo": adminEquipo.correo,
        "NombreEquipo": adminEquipo.equipo,
        "Liga": adminEquipo.liga,
        "Dias": adminEquipo.dias,
        "Contraseña": adminEquipo.contrasena
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
