import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/solicitudJugador.dart';

// Clase para gestionar (hacer operaciones CRUD) de datos en la base de datos, comunicandose con el servidor

class ProveedorSolicitudesJugador {
  Future anadirSolicitudJugador(SolicitudJugador solicitudJugador) async {
    //Y aquí nos comunicamos con la base de datos
    http.Response response = await http.post(
      //Usamos la extensión http de dart, que nos permite hacer posts y gets en el servidor
      'https://futmxpr.000webhostapp.com/app/insertSolicitudJugador2.php', //Insertamos el url de donde está la interacción con la base de datos (los insert, delete), o stored procedures
      body: {
        //En el caso de post, al utilizar php, asignamos los datos que se necesitan para hacer la transacción con la base de datos
        "Cedula": solicitudJugador.cedula,
        "Nombre": solicitudJugador.nombre,
        "Correo": solicitudJugador.correo,
        "Equipo": solicitudJugador.equipo,
        "Numero": solicitudJugador.numero,
        "Contraseña": solicitudJugador.contrasena
      },
    );
    String body = response
        .body; //Almacenamos la respuesta que se nos de en body (normalmente en php se maneja con un "echo")
        print(body);
      print("holaaaaaa");
    if (response.statusCode == 200) {
      //statusCode!= 200... Hubo un error :c
      return body; // Si el sistema llega hasta acá, bien, se comunicó con el servidor, este devolverá un error o nada(no hubo errores), pero eso ya depende del código de acceso a la bd (puro php y mysql)
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  Future eliminarSolicitudJugador(String cedula) async {
    //Y aquí nos comunicamos con la base de datos
    http.Response response = await http.post(
      //Usamos la extensión http de dart, que nos permite hacer posts y gets en el servidor
      'https://futmxpr.000webhostapp.com/app/deleteSolicitudJugador.php', //Insertamos el url de donde está la interacción con la base de datos (los insert, delete), o stored procedures
      body: {
        //En el caso de post, al utilizar php, asignamos los datos que se necesitan para hacer la transacción con la base de datos
        "Cedula": cedula
      },
    );
    String body = response
        .body; //Almacenamos la respuesta que se nos de en body (normalmente en php se maneja con un "echo")
    if (response.statusCode == 200) {
      //statusCode!= 200... Hubo un error :c
      return body; // Si el sistema llega hasta acá, bien, se comunicó con el servidor, este devolverá un error o nada(no hubo errores), pero eso ya depende del código de acceso a la bd (puro php y mysql)
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  Future obtenerJugador(controllerCedula) async {
    http.Response responseUsuarioInscrito = await http
        .post('https://futmxpr.000webhostapp.com/app/getJugador.php', body: {
      "Cedula": controllerCedula.text,
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

  Future<SolicitudJugadorModel> obtenerSolicitudesJugadorEquipo(
      String equipo) async {
    List<SolicitudJugador> _solicitudesJugador = [];
    var solicitudes;
    http.Response responseSolicitudesJugadorEquipo = await http.post(
        'https://futmxpr.000webhostapp.com/app/getSolicitudesJugadorEquipo.php',
        body: {
          "Equipo": equipo,
        });
    int statusCode = responseSolicitudesJugadorEquipo.statusCode;
    var data = jsonDecode(responseSolicitudesJugadorEquipo.body);
    var respuestaUsuario = data.toString();
    if (statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(responseSolicitudesJugadorEquipo.body.length);
      if (responseSolicitudesJugadorEquipo.body.length>2) {
        solicitudes = SolicitudJugadorModel.fromJson(
            json.decode(responseSolicitudesJugadorEquipo.body));
      } else {
        solicitudes = new SolicitudJugadorModel(_solicitudesJugador);
      }

      return solicitudes;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
