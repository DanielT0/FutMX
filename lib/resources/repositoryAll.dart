import 'package:prueba_bd/models/liga.dart';
import 'package:prueba_bd/resources/adminEquipo_red.dart';
import 'package:prueba_bd/resources/ligas_red.dart';
import 'package:prueba_bd/resources/solicitudAdminEquipo_red.dart';
import 'package:prueba_bd/resources/equipo_red.dart';
import './solicitudJugador_red.dart';
import 'package:prueba_bd/resources/jugador_red.dart';
import 'package:prueba_bd/resources/usuario_red.dart';

import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/adminEquipo.dart';
import 'package:prueba_bd/models/equipo.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/models/usuario.dart';

class RepositoryAll {
  final gestorSolicitudJugador = ProveedorSolicitudesJugador();
  final gestorAdminEquipo = ProveedorAdministradorEquipo();
  final gestorSolicitudAdminEquipo = ProveedorSolicitudAdminEquipo();
  final gestorLigas = ProveedorLigas();
  final gestorEquipos = ProveedorEquipo();
  final gestorJugadores = ProveedorJugador();
  final gestorUsuarios = ProveedorUsuario();

  //Ligas
  Future<LigaModel> obtenerAllLigas() => gestorLigas.obtenerListaLigas();

  //Solicitud Jugador
  Future insertSolicitudJugador(SolicitudJugador solicitud) {
    //Es algo parecido a lo que hace el bloc, pero sin await, llama directamente a quien interactua con los datos (por lo que interactuan con los datos por medio de la red... llevaran red en el nombre)
    var resp = gestorSolicitudJugador.anadirSolicitudJugador(
        solicitud); //Aquí aparecen un tipo de "gestores", los cuales controlan las llamadas, cada uno para una entidad, cuyas clases están en esta misma carpeta, en el archivo con su respectivo nombre
    return resp; //De nuevo, se retorna la repuesta
  }

  Future deleteSolicitudJugador(String cedula) {
    var resp = gestorSolicitudJugador.eliminarSolicitudJugador(cedula);
    return resp;
  }

  Future<SolicitudJugadorModel> obtenerSolicitudesJugadorEquipo(equipo) =>
      gestorSolicitudJugador.obtenerSolicitudesJugadorEquipo(equipo);

  //Solicitud Admin
  Future insertSolicitudAdminEquipo(SolicitudAdministradorEquipo solicitud) {
    var resp = gestorSolicitudAdminEquipo
        .anadirSolicitudAdministradorEquipo(solicitud);
    return resp;
  }

  //Usuario
  Future<Usuario> obtenerUsuarioCedula(String cedula) =>
      gestorUsuarios.obtenerUsuarioCedula(cedula);

  Future<Usuario> obtenerUsuarioCorreo(String correo) =>
      gestorUsuarios.obtenerUsuarioCorreo(correo);

  //Admin
  Future<AdministradorEquipo> obtenerAdminCedula(String cedula) =>
      gestorAdminEquipo.obtenerAdminCedula(cedula);

  Future<AdministradorEquipo> obtenerAdminCorreo(String correo) =>
      gestorAdminEquipo.obtenerAdminCorreo(correo);

  //Jugador
  Future<Jugador> obtenerJugadorCedula(String cedula) =>
      gestorJugadores.obtenerJugadorCedula(cedula);

  Future insertJugador(String cedula) =>
      gestorJugadores.anadirJugador(cedula);

  //Equipo
  Future<Equipo> obtenerEquipoNombre(String nombre) =>
      gestorEquipos.obtenerEquipoNombre(nombre);
}
