import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/solicitudJugador.dart';

// Clase para gestionar (hacer operaciones CRUD) de datos en la base de datos, comunicandose con el servidor

class ProveedorSolicitudesJugador {
  Future anadirSolicitudJugador(SolicitudJugador solicitudJugador) async { //Y aquí nos comunicamos con la base de datos
    http.Response response = await http.post( //Usamos la extensión http de dart, que nos permite hacer posts y gets en el servidor
      'https://futmxpr.000webhostapp.com/app/insertSolicitudJugador2.php', //Insertamos el url de donde está la interacción con la base de datos (los insert, delete), o stored procedures
      body: {                                                            //En el caso de post, al utilizar php, asignamos los datos que se necesitan para hacer la transacción con la base de datos
        "Cedula": solicitudJugador.cedula,
        "Nombre": solicitudJugador.nombre,
        "Correo": solicitudJugador.correo,
        "Equipo": solicitudJugador.equipo,
        "Numero" : solicitudJugador.numero,
        "Contraseña": solicitudJugador.contrasena
      },
    );
    String body = response.body;                                  //Almacenamos la respuesta que se nos de en body (normalmente en php se maneja con un "echo")
    if (response.statusCode == 200) {  //statusCode!= 200... Hubo un error :c
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
}
