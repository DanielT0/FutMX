import 'package:prueba_bd/models/liga.dart';
import 'package:prueba_bd/resources/adminEquipo_red.dart';
import 'package:prueba_bd/resources/ligas_red.dart';
import 'package:prueba_bd/resources/solicitudAdminEquipo_red.dart';

import './solicitudJugador_red.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/adminEquipo.dart';

class RepositoryAll {
  final gestorSolicitudJugador = ProveedorSolicitudesJugador();
  final gestorAdminEquipo = ProveedorAdministradorEquipo();
  final gestorSolicitudAdminEquipo = ProveedorSolicitudAdminEquipo();
  final gestorLigas = ProveedorLigas();

  //Ligas
  Future<LigaModel> obtenerAllLigas() => gestorLigas.obtenerListaLigas();

  //Solicitud Jugador
  Future insertSolicitudJugador(SolicitudJugador solicitud) {
    //Es algo parecido a lo que hace el bloc, pero sin await, llama directamente a quien interactua con los datos (por lo que interactuan con los datos por medio de la red... llevaran red en el nombre)
    var resp = gestorSolicitudJugador.anadirSolicitudJugador(
        solicitud); //Aquí aparecen un tipo de "gestores", los cuales controlan las llamadas, cada uno para una entidad, cuyas clases están en esta misma carpeta, en el archivo con su respectivo nombre
    return resp; //De nuevo, se retorna la repuesta
  }

  //Solicitud Admin
  Future insertSolicitudAdminEquipo(SolicitudAdministradorEquipo solicitud) {
    var resp = gestorSolicitudAdminEquipo
        .anadirSolicitudAdministradorEquipo(solicitud);
    return resp;
  }

  //Admin
  
  Future<AdministradorEquipo> obtenerAdminCedula(String cedula) => gestorAdminEquipo.obtenerAdminCedula(cedula);
}
