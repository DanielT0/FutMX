import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/liga.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/resources/repositoryAll.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/models/adminEquipo.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

//Bloc tiene el control de toda la lógica del programa, haciendo que la capa vista interactue con los datos solamente mediante este
class Bloc {
  //Get instance of the Repository
  final _repository = RepositoryAll();

  final _ligasFetcher = PublishSubject<
      LigaModel>(); // Usados para streams, devuelven el valor más reciente del objeto encontrado en la base de datos
  final _solicitudJugadorFetcher = PublishSubject<SolicitudJugadorModel>();

  //Solicitudes Jugador
  Future addSolicitudJugador(
      SolicitudJugador solicitud, BuildContext context) async {
    //Clase Future, clase asíncrona, además esperamos a que ocurra algo, así que ponemos un await, llamando a nuestro repositorio
    var dato;
    var ejecutar1, ejecutar2;
    var mensaje;
    var color = Colors.red;
    this.getUsuarioCedula(solicitud.cedula).then(
      (resp) {
        if (resp == null) {
          ejecutar1 = true;
        } else {
          ejecutar1 = false;
          mensaje = 'Ya existe un usuario con esa cédula';
        }
      },
    ).then((resp) {
      this.getUsuarioCorreo(solicitud.correo).then((resp) {
        if (resp == null) {
          ejecutar2 = true;
        } else {
          ejecutar2 = false;
          mensaje = 'Ya existe un usuario con ese correo';
        }
      }).then(
        (resp) {
          if (ejecutar1 && ejecutar2) {
            dato = _repository.insertSolicitudJugador(
                solicitud); //El repositorio llamará a la clase que interactúa con el servidor.. vamos allá (carpeta resources, repositoryAll)
            if (dato == // Validaciones... tomamos cada uno de los errores que nos puede retornar el servidor y asignamos una salida
                "prepare() failed: Cannot add or update a child row: a foreign key constraint fails (`id12947947_futmx`.`solicitudesJugador`, CONSTRAINT `fk_equipoSolicitudJugador` FOREIGN KEY (`Id_Equipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE)") {
              mensaje = 'No existe ningún equipo con el ID ingresado';
            } else if (resp ==
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
        },
      );
      return resp; //Dato toma el valor de la respuesta dada por el servidor (lo usamos para manejar errores con snackbars en la interfaz)
    });
  }

  Stream<SolicitudJugadorModel> get solicitudesJugadorEquipo =>
      _solicitudJugadorFetcher.stream;

  obtenerSolicitudesJugadorEquipo(String equipo) async {
    SolicitudJugadorModel solicitud =
        await _repository.obtenerSolicitudesJugadorEquipo(equipo);
    _solicitudJugadorFetcher.sink.add(solicitud);
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
    this.getUsuarioCedula(solicitud.cedula).then(
      (resp) {
        if (resp == null) {
          ejecutar1 = true;
        } else {
          ejecutar1 = false;
          mensaje = 'Ya existe un usuario con esa cédula';
        }
      },
    ).then(
      (resp) {
        this.getUsuarioCorreo(solicitud.correo).then(
          (resp) {
            if (resp == null) {
              ejecutar = true;
            } else {
              ejecutar = false;
              mensaje = 'Ya existe un usuario con ese correo';
            }
          },
        ).then(
          (resp) {
            this.getEquipoNombre(solicitud.equipo).then((resp) {
              if (resp == null) {
                ejecutar2 = true;
              } else {
                ejecutar2 = false;
                mensaje = 'Ya existe un equipo con ese nombre';
              }
            }).then(
              (resp) {
                if (ejecutar && ejecutar1 && ejecutar2) {
                  dato = _repository.insertSolicitudAdminEquipo(
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
                    mensaje =
                        'Ya existe una solicitud con ese nombre de usuario';
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
              },
            );
          },
        );
      },
    );
  }

  Future iniciarSesion(
      String correo, String contrasena, BuildContext context) async {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    var respuesta = false;
    var resp = await this._repository.obtenerUsuarioCorreo(correo);
    if (resp != null) {
          if (contrasena == resp.contrasena) {
            respuesta = true;
          } else {
            respuesta = false;
          }
          this._repository.obtenerJugadorCedula(resp.cedula).then(
            (respJugador) {
              if (respJugador != null) {
                Jugador jugador = new Jugador(
                    resp.cedula,
                    resp.nombre,
                    resp.correo,
                    respJugador.equipo,
                    respJugador.numero,
                    resp.contrasena);
                myProvider.jugadorUser = jugador;
                myProvider.tipo = "Jugador";
              } else {
                this._repository.obtenerAdminCedula(resp.cedula).then(
                  (respAdmin) {
                    AdministradorEquipo admin = new AdministradorEquipo(
                        resp.cedula,
                        resp.nombre,
                        resp.correo,
                        respAdmin.equipo,
                        resp.contrasena);
                    myProvider.administradorUser = admin;
                    myProvider.tipo = "Administrador Equipo";
                  },
                );
              }
            },
          );
        } else {
          respuesta = false;
        }
    print(respuesta);
    return respuesta;
  }

  //Usuario
  Future getUsuarioCedula(String cedula) async {
    var user = await _repository.obtenerUsuarioCedula(
        cedula); // El código es muy parecido, sólo cambian las entidades
    return user;
  }

  Future getUsuarioCorreo(String correo) async {
    var user = await _repository.obtenerUsuarioCorreo(correo);
    return user;
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

  //Jugador
  Future getJugadorCedula(String cedula) async {
    var jugador = await _repository.obtenerJugadorCedula(
        cedula); // El código es muy parecido, sólo cambian las entidades
    return jugador;
  }

  //Pedir todas las ligas
  Stream<LigaModel> get allLigas => _ligasFetcher.stream;

  obtenerTodasLigas() async {
    LigaModel liga = await _repository.obtenerAllLigas();
    _ligasFetcher.sink.add(liga);
  }

  disposeLigas() {
    _ligasFetcher.close();
  }

  // Equipos
  Future getEquipoNombre(String nombre) async {
    var admin = await _repository.obtenerEquipoNombre(nombre);
    return admin;
  }
}

final bloc = Bloc();
