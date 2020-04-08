import 'package:prueba_bd/models/adminEquipo.dart';
import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/liga.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/resources/repositoryAll.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

//Bloc tiene el control de toda la lógica del programa, haciendo que la capa vista interactue con los datos solamente mediante este
class Bloc {
  //Get instance of the Repository
  final _repository = RepositoryAll();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _jugadorController =
      StreamController<List<SolicitudJugador>>.broadcast();
  final _ligasFetcher = PublishSubject<LigaModel>();
  final _adminFetcher = PublishSubject<AdministradorEquipo>();

  //Solicitudes Jugador
  Future addSolicitudJugador(SolicitudJugador solicitud) async {
    //Clase Future, clase asíncrona, además esperamos a que ocurra algo, así que ponemos un await, llamando a nuestro repositorio
    var dato = await _repository.insertSolicitudJugador(
        solicitud); //El repositorio llamará a la clase que interactúa con el servidor.. vamos allá (carpeta resources, repositoryAll)
    return dato; //Dato toma el valor de la respuesta dada por el servidor (lo usamos para manejar errores con snackbars en la interfaz)
  }

  // Solicitudes Admin
  Future addSolicitudAdminEquipo(
      SolicitudAdministradorEquipo solicitud, BuildContext context) async {
    var ejecutar = true;
    var dato;
    this.getAdminCedula(solicitud.cedula).then(
      (resp) {
        if (resp == null) {
          ejecutar = true;
        } else {
          ejecutar=false;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Ya existe un usuario con esa cédula'),
            backgroundColor: Colors.red,
          ));
        }
      },
    );
    if (ejecutar) {
      dato = await _repository.insertSolicitudAdminEquipo(
          solicitud); // El código es muy parecido, sólo cambian las entidades
      if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.cedula +
              "' for key 'PRIMARY'")) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Ya existe una solicitud de este usuario'),
          backgroundColor: Colors.red,
        ));
      } else if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.nombre +
              "' for key 'Nombre_Usuario'")) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Ya existe una solicitud con ese nombre de usuario'),
          backgroundColor: Colors.red,
        ));
      } else if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.equipo +
              "' for key 'Nombre_Equipo'")) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Ya existe una solicitud de ese equipo'),
          backgroundColor: Colors.red,
        ));
      } else if (dato ==
          ("prepare() failed: Duplicate entry '" +
              solicitud.correo +
              "' for key 'Correo'")) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Ya existe una solicitud con ese correo'),
          backgroundColor: Colors.red,
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Solicitud enviada'),
          backgroundColor: Colors.green,
        ));
      }
    } else
      dato = 'No se ejecutó';
    return dato;
  }

  //Admin
  Future getAdminCedula(String cedula) async {
    var admin = await _repository.obtenerAdminCedula(
        cedula); // El código es muy parecido, sólo cambian las entidades
    return admin;
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
}

final bloc = Bloc();
