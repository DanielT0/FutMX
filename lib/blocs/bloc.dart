import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/models/partido.dart';
import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/liga.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/resources/repositoryAll.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/models/adminEquipo.dart';
import 'package:prueba_bd/models/equipo.dart';
import 'package:prueba_bd/models/posicion.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prueba_bd/ui/Widgets/alert.dart';
import 'package:prueba_bd/ui/screens/interfazInicioSesion.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

//Bloc tiene el control de toda la lógica del programa, haciendo que la capa vista interactue con los datos solamente mediante este
class Bloc {
  //Get instance of the Repository
  final _repository = RepositoryAll();
  final Alerta alerta = Alerta();

  final _ligasFetcher = PublishSubject<
      ApiResponse<
          LigaModel>>(); // Usados para streams, devuelven el valor más reciente del objeto encontrado en la base de datos
  final _solicitudJugadorFetcher =
      PublishSubject<ApiResponse<SolicitudJugadorModel>>();

  final _partidosFetcher = PublishSubject<ApiResponse<PartidoModel>>();
  final _anterioresPartidosFetcher =
      PublishSubject<ApiResponse<PartidoModel>>();
  final _posicionesFetcher = PublishSubject<ApiResponse<PosicionModel>>();
  final _jugadoresFetcher = PublishSubject<ApiResponse<JugadorModel>>();

  //Solicitudes Jugador
  Future addSolicitudJugador(
      SolicitudJugador solicitud, BuildContext context) async {
    //Clase Future, clase asíncrona, además esperamos a que ocurra algo, así que ponemos un await, llamando a nuestro repositorio
    var dato;
    var ejecutar1, ejecutar2;
    var mensaje;
    var color = Colors.red;
    try {
      var resp = await this.getUsuarioCedula(solicitud.cedula);
      if (resp == null) {
        ejecutar1 = true;
      } else {
        ejecutar1 = false;
        mensaje = 'Ya existe un usuario con esa cédula';
      }

      var respuesta = await this.getUsuarioCorreo(solicitud.correo);
      if (respuesta == null) {
        ejecutar2 = true;
      } else {
        ejecutar2 = false;
        mensaje = 'Ya existe un usuario con ese correo';
      }
      if (ejecutar1 && ejecutar2) {
        dato = await _repository.insertSolicitudJugador(
            solicitud); //El repositorio llamará a la clase que interactúa con el servidor.. vamos allá (carpeta resources, repositoryAll)
        if (dato == // Validaciones... tomamos cada uno de los errores que nos puede retornar el servidor y asignamos una salida
            "prepare() failed: Cannot add or update a child row: a foreign key constraint fails (`id12947947_futmx`.`solicitudesJugador`, CONSTRAINT `fk_equipoSolicitudJugador` FOREIGN KEY (`Id_Equipo`) REFERENCES `equipos` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE)") {
          mensaje = 'No existe ningún equipo con el ID ingresado';
        } else if (dato ==
                ("prepare() failed: Duplicate entry '" +
                    solicitud.cedula +
                    "' for key 'PRIMARY'") ||
            dato ==
                ("prepare() failed: Duplicate entry '" +
                    solicitud.nombre +
                    "' for key 'Nombre_Jugador'")) {
          mensaje = 'Ya existe una solicitud de este jugador';
        } else if (dato ==
            ("prepare() failed: Duplicate entry '" +
                solicitud.numero +
                "' for key 'fk_unicoNumero'")) {
          mensaje = 'Ya existe una solicitud con ese número de jugador';
        } else if (dato ==
            ("prepare() failed: Duplicate entry '" +
                solicitud.correo +
                "' for key 'Correo'")) {
          mensaje = 'Ya existe una solicitud con ese correo';
        } else {
          mensaje = 'Solicitud enviada';
          color = Colors.green;
        }
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: color,
        ),
      );
      return resp; //Dato toma el valor de la respuesta dada por el servidor (lo usamos para manejar errores con snackbars en la interfaz)
    } on Exception {
      Alert(
              context: context,
              title: 'Hubo un error en la conexión',
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
              type: AlertType.error,
              desc: 'Verifica tu conexión a internet e intentalo de nuevo')
          .show();
    }
  }

  Future deleteSolicitudJugador(String cedula) async {
    var resp;
    try {
      resp = await this._repository.deleteSolicitudJugador(cedula);
    } on Exception {
      {
        print('Error');
      }
    }
    return resp;
  }

  Stream<ApiResponse<SolicitudJugadorModel>> get solicitudesJugadorEquipo =>
      _solicitudJugadorFetcher.stream;

  obtenerSolicitudesJugadorEquipo(String equipo, BuildContext context) async {
    SolicitudJugadorModel solicitud;
    try {
      solicitud = await _repository.obtenerSolicitudesJugadorEquipo(equipo);
      _solicitudJugadorFetcher.sink.add(ApiResponse.completed(solicitud));
    } on Exception {
      _solicitudJugadorFetcher.sink.add(ApiResponse.error());
    }
  }

  disposeSolicitudesJugadorEquipo() {
    _solicitudJugadorFetcher.close();
  }

  // Solicitudes Admin
  Future addSolicitudAdminEquipo(
      SolicitudAdministradorEquipo solicitud, BuildContext context) async {
    //Antes de añadir el admin, hacemos las validaciones necesarias, también podemos hacerlo desde la clase de interfaz, pero el bloc se encarga de la lógica so...
    var ejecutar = true; //Booleans para saber si se retornó un datos
    var ejecutar1 = true;
    var ejecutar2 = true;
    var mensaje;
    var color = Colors.red;
    var dato;
    var resp = await this.getUsuarioCedula(solicitud.cedula);
    if (resp == null) {
      ejecutar1 = true;
    } else {
      ejecutar1 = false;
      mensaje = 'Ya existe un usuario con esa cédula';
    }
    var respuesta = await this.getUsuarioCorreo(solicitud.correo);
    if (respuesta == null) {
      ejecutar = true;
    } else {
      ejecutar = false;
      mensaje = 'Ya existe un usuario con ese correo';
    }
    var respuesta2 = await this.getEquipoNombre(solicitud.equipo);
    if (respuesta2 == null) {
      ejecutar2 = true;
    } else {
      ejecutar2 = false;
      mensaje = 'Ya existe un equipo con ese nombre';
    }

    if (ejecutar && ejecutar1 && ejecutar2) {
      dato = await _repository.insertSolicitudAdminEquipo(
          solicitud); // El código es muy parecido, sólo cambian las entidades
      if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.cedula +
              "' for key 'PRIMARY'")) {
        mensaje = 'Ya existe una solicitud de este usuario';
      } else if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.nombre +
              "' for key 'Nombre_Usuario'")) {
        mensaje = 'Ya existe una solicitud con ese nombre de usuario';
      } else if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.equipo +
              "' for key 'Nombre_Equipo'")) {
        mensaje = 'Ya existe una solicitud de ese equipo';
      } else if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.correo +
              "' for key 'Correo'")) {
        mensaje = 'Ya existe una solicitud con ese correo';
      } else {
        mensaje = 'Solicitud enviada';
        color = Colors.green;
      }
    } else
      dato = 'No se ejecutó';
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: color,
      ),
    );
    return dato;
  }

  Future iniciarSesion(
      String correo, String contrasena, BuildContext context) async {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    var respuesta = false;
    var resp = await this.getUsuarioCorreo(correo);
    if (resp != null) {
      if (contrasena == resp.contrasena) {
        respuesta = true;
      } else {
        respuesta = false;
      }
      var respJugador = await this.getJugadorCedula(resp
          .cedula); //Si el usuario es un jugador, tomamos todos los valores necesarios (liga, equipo, datos personales) y los guardamos en nuestro provider
      if (respJugador != null) {
        Jugador jugador = new Jugador(resp.cedula, resp.nombre, resp.correo,
            respJugador.equipo, respJugador.numero, resp.contrasena, resp.foto);
        myProvider.jugadorUser = jugador;
        myProvider.tipo = "Jugador";
        var equipo = await this.getEquipoId(respJugador.equipo);
        myProvider.equipo = equipo;
        var liga = await this.getLigaId(equipo.idLiga);
        myProvider.liga = liga;
        print(myProvider.equipo.nombre);
      } else {
        var respAdmin = await this.getAdminCedula(resp.cedula);
        AdministradorEquipo admin = new AdministradorEquipo(
            resp.cedula,
            resp.nombre,
            resp.correo,
            respAdmin.equipo,
            resp.contrasena,
            resp.foto);
        myProvider.administradorUser = admin;
        myProvider.tipo = "Administrador Equipo";
        var equipo = await this.getEquipoId(respAdmin.equipo);
        myProvider.equipo = equipo;
        var liga = await this.getLigaId(equipo.idLiga);
        myProvider.liga = liga;
      }
    } else {
      respuesta = false;
    }
    return respuesta;
  }

  //Usuario
  Future getUsuarioCedula(String cedula) async {
    var user;
    try {
      user = await _repository.obtenerUsuarioCedula(
          cedula); // El código es muy parecido, sólo cambian las entidades
    } on Exception {
      throw Exception();
    }
    return user;
  }

  Future getUsuarioCorreo(String correo) async {
    var user;
    try {
      user = await _repository.obtenerUsuarioCorreo(correo);
    } on Exception {
      throw Exception();
    }
    return user;
  }

  Future updateCedulaUsuario(String cedula, String nuevoDato) async {
    var ejecutado;
    try {
      var dato = await _repository.updateCedulaUsuario(cedula, nuevoDato);
      ejecutado = true;
    } on Exception {
      ejecutado = false;
    }
    return ejecutado;
  }

  Future updateImageUsuario(String id, String base64Image, fileName) async {
    var ejecutado;
    try {
      await _repository.uploadImage(id, base64Image, fileName);
      ejecutado = true;
    } on Exception {
      ejecutado = false;
    }
    if (ejecutado) {
      try {
        await _repository.updateImageUsuario(id, fileName);
      } on Exception {
        ejecutado = false;
      }
    }
    return ejecutado;
  }

  Future updateNombreUsuario(String id, String nombre) async {
    var dato;
    try {
      await _repository.updateNombreUsuario(id, nombre);
      dato = true;
    } on Exception {
      dato = false;
    }
    return dato;
  }

  Future updateCorreoUsuario(String id, String correo) async {
    var dato;
    try {
      dato = await _repository.updateCorreoUsuario(id, correo);
    } on Exception {
      dato = true;
    }
    return dato;
  }

  Future updateContrasenaUsuario(String id, String contrasena) async {
    var dato;
    try {
      await _repository.updateContrasenaUsuario(id, contrasena);
      dato = true;
    } on Exception {
      dato = false;
    }
    return dato;
  }

  //Admin
  Future getAdminCedula(String cedula) async {
    var admin = await _repository.obtenerAdminCedula(
        cedula); // El código es muy parecido, sólo cambian las entidades
    return admin;
  }

  Future getAdminCorreo(String correo) async {
    var admin = await _repository.obtenerAdminCorreo(correo);
    return admin;
  }

  Future updateAdminEquipo(
      String cedula, AdministradorEquipo admin, BuildContext context) async {
    //Antes de añadir el admin, hacemos las validaciones necesarias, también podemos hacerlo desde la clase de interfaz, pero el bloc se encarga de la lógica so...
    var mensaje;
    var color = Colors.red;
    var dato;

    dato = await _repository.updateAdminEquipo(
        cedula, admin); // El código es muy parecido, sólo cambian las entidades
    if (dato ==
        ("prepare() failed: Duplicate entry '" +
            admin.cedula +
            "' for key 'PRIMARY'")) {
      mensaje = 'Ya existe un usuario con esta identificación';
    } else if (dato ==
        ("prepare() failed: Duplicate entry '" +
            admin.nombre +
            "' for key 'Nombre_Usuario'")) {
      mensaje = 'Ya existe un usuario con ese nombre';
    } else if (dato ==
        ("prepare() failed: Duplicate entry '" +
            admin.correo +
            "' for key 'Correo'")) {
      mensaje = 'Ya existe un usuario con ese correo';
    } else {
      mensaje = 'Solicitud enviada';
      color = Colors.green;
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: color,
      ),
    );
    return dato;
  }

  //Jugador
  Future getJugadorCedula(String cedula) async {
    var jugador = await _repository.obtenerJugadorCedula(cedula);
    return jugador;
  }

  Future<Jugador> getJugadorNumero(String numero, String equipo) async {
    var jugador = await _repository.obtenerJugadorNumero(numero, equipo);
    return jugador;
  }

  Future addJugador(String cedula) async {
    var jugador = await _repository.insertJugador(cedula);
    return jugador;
  }

  Future updateJugador(Jugador jugador, BuildContext context) async {}

  Stream<ApiResponse<JugadorModel>> get jugadoresEquipo =>
      _jugadoresFetcher.stream;

  obtenerJugadoresEquipo(String equipo, BuildContext context) async {
    JugadorModel jugador;
    try {
      jugador = await _repository.obtenerJugadoresEquipo(equipo);
      _jugadoresFetcher.sink.add(ApiResponse.completed(jugador));
    } on Exception {
      _jugadoresFetcher.sink.add(ApiResponse.error());
    }
  }

  disposeJugadores() {
    _jugadoresFetcher.close();
  }

  Future updateNumeroJugador(
      BuildContext context, String cedula, String numero, String equipo) async {
    var dato = false;
    try {
      Jugador jugador = await this.getJugadorNumero(numero, equipo);
      if (jugador != null) {
        print(jugador);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Ya existe un jugador en el equipo con ese número'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        this._repository.updateNumeroJugador(cedula, numero);
        dato = true;
      }
    } on Exception {
      Alert(
              context: context,
              title: 'Hubo un error en la conexión',
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
              type: AlertType.error,
              desc: 'Verifica tu conexión a internet e intentalo de nuevo')
          .show();
      dato = false;
    }
    return dato;
  }

  //Ligas

  Future<Liga> getLigaId(idLiga) async {
    var liga = await this._repository.obtenerLigaId(idLiga);
    return liga;
  }

  //Pedir todas las ligas
  Stream<ApiResponse<LigaModel>> get allLigas => _ligasFetcher.stream;

  obtenerTodasLigas() async {
    try {
      LigaModel liga = await _repository.obtenerAllLigas();
      _ligasFetcher.sink.add(ApiResponse.completed(liga));
    } on Exception {
      _ligasFetcher.sink.add(ApiResponse.error());
    }
  }

  disposeLigas() {
    _ligasFetcher.close();
  }

  // Equipos
  Future getEquipoNombre(String nombre) async {
    var admin = await _repository.obtenerEquipoNombre(nombre);
    return admin;
  }

  Future<Equipo> getEquipoId(String id) async {
    var admin;
    try {
      admin = await _repository.obtenerEquipoId(id);
    } on Exception {
      throw Exception();
    }
    return admin;
  }

  Future updateNombreEquipo(
      BuildContext context, String idEquipo, String newNombre) async {
    var dato;
    try {
      Equipo equipo = await this._repository.obtenerEquipoNombre(newNombre);
      if (equipo != null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Ya existe un equipo con ese nombre'),
            backgroundColor: Colors.red,
          ),
        );
        dato = true;
      } else {
        dato = await this._repository.updateNombreEquipo(idEquipo, newNombre);
      }
    } on Exception {
      Alert(
              context: context,
              title: 'Hubo un error en la conexión',
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
              type: AlertType.error,
              desc: 'Verifica tu conexión a internet e intentalo de nuevo')
          .show();
      dato = false;
    }
    return dato;
  }

  Future deleteEquipo(BuildContext context, String idEquipo) async {
    var dato;
    try {
      dato = await this._repository.deleteEquipo(idEquipo);
    } on Exception {
      dato = false;
    }
    return dato;
  }

  Future updateImageEquipo(String id, String base64Image, fileName) async {
    var ejecutado;
    try {
      await _repository.uploadImage(id, base64Image, fileName);
      ejecutado = true;
    } on Exception {
      ejecutado = false;
    }
    if (ejecutado) {
      try {
        await _repository.updateImageEquipo(id, fileName);
      } on Exception {
        ejecutado = false;
      }
    }
    return ejecutado;
  }

  //Partidos

  Future prepararDatosPago(String partido, String equipo, String cuota) async {
    var preparar = _repository.prepararDatosPago(partido, equipo, cuota);
    return preparar;
  }

  Stream<ApiResponse<PartidoModel>> get proximosPartidos =>
      _partidosFetcher.stream;

  Stream<ApiResponse<PartidoModel>> get anterioresPartidos =>
      _anterioresPartidosFetcher.stream;

  obtenerProximosPartidos(String cedula, BuildContext context) async {
    try {
      PartidoModel partido = await _repository.obtenerProximosPartidos(cedula);
      _partidosFetcher.sink.add(ApiResponse.completed(partido));
    } on Exception {
      _partidosFetcher.sink.add(ApiResponse.error());
    }
  }

  obtenerAnterioresPartidos(String cedula, BuildContext context) async {
    try {
      PartidoModel partido =
          await _repository.obtenerAnterioresPartidos(cedula);
      _anterioresPartidosFetcher.sink.add(ApiResponse.completed(partido));
    } on Exception {
      _anterioresPartidosFetcher.sink.add(ApiResponse.error());
    }
  }

  disposeAnterioresPartidos() {
    _anterioresPartidosFetcher.close();
  }

  disposePartidos() {
    _partidosFetcher.close();
  }

  //Posiciones
  Stream<ApiResponse<PosicionModel>> get posiciones =>
      _posicionesFetcher.stream;

  obtenerPosiciones(String idLiga, BuildContext context) async {
    PosicionModel posicion;
    try {
      posicion = await _repository.obtenerPosiciones(idLiga);
      _posicionesFetcher.sink.add(ApiResponse.completed(posicion));
    } on Exception {
      _posicionesFetcher.sink.add(ApiResponse.error());
    }
  }

  disposePosiciones() {
    _posicionesFetcher.close();
  }
}

final bloc = Bloc();
