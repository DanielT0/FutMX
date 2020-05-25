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
        'https://futbolmx1.000webhostapp.com/app/getUsuarioCedula.php',
        body: {"Cedula": cedula});
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      if (json.decode(response.body) == false) {
        admin = null;
      } else
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
        'https://futbolmx1.000webhostapp.com/app/getUsuarioCorreo.php',
        body: {"Correo": correo});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(json.decode(response.body));
      if (json.decode(response.body) == false) {
        admin = null;
      } else
        admin = Usuario.fromJson(json.decode(response.body));
      return admin;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future anadirSolicitudCedula(String idAntig, String idNew) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertSolicitudCedula.php',
      body: {
        "Cedula": idNew,
        "Antigua": idAntig,
      },
    );
    String body = response.body;
    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  Future anadirSolicitudNombre(String id, String nombre) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/insertSolicitudNombre.php',
      body: {
        "Cedula": id,
        "Nombre": nombre,
      },
    );
    String body = response.body;
    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  Future updateCorreoUsuario(String id, String correo) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/updateCorreoUsuario.php',
      body: {
        "Cedula": id,
        "Correo": correo,
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

  Future updateContrasenaUsuario(String id, String contrasena) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/updateContrasenaUsuario.php',
      body: {
        "Cedula": id,
        "Contrasena": contrasena,
      },
    );
    String body = response.body;
    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  Future uploadImage(
      String id, String base64Image, String fileName) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/imagenes/uploadImage.php',
      body: {
        "image": base64Image,
        "name": fileName,
      },
    );
    String body = response.body;
    print(response.statusCode);
    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  Future updateImageUsuario(String id, String image) async {
    // make POST request
    http.Response response = await http.post(
      'https://futbolmx1.000webhostapp.com/app/updateImageUsuario.php',
      body: {
        "Cedula": id,
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
