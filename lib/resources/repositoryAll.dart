import 'package:prueba_bd/models/liga.dart';
import 'package:prueba_bd/resources/adminEquipo_red.dart';
import 'package:prueba_bd/resources/ligas_red.dart';
import 'package:prueba_bd/resources/solicitudAdminEquipo_red.dart';
import 'package:prueba_bd/resources/equipo_red.dart';
import './solicitudJugador_red.dart';
import 'package:prueba_bd/resources/jugador_red.dart';
import 'package:prueba_bd/resources/usuario_red.dart';
import 'package:prueba_bd/resources/partidos_red.dart';
import 'package:prueba_bd/resources/posiciones_red.dart';

import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/adminEquipo.dart';
import 'package:prueba_bd/models/equipo.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/models/usuario.dart';
import 'package:prueba_bd/models/partido.dart';
import 'package:prueba_bd/models/posicion.dart';

class RepositoryAll {
  final gestorSolicitudJugador = ProveedorSolicitudesJugador();
  final gestorAdminEquipo = ProveedorAdministradorEquipo();
  final gestorSolicitudAdminEquipo = ProveedorSolicitudAdminEquipo();
  final gestorLigas = ProveedorLigas();
  final gestorEquipos = ProveedorEquipo();
  final gestorJugadores = ProveedorJugador();
  final gestorUsuarios = ProveedorUsuario();
  final gestorPartidos = ProveedorPartidos();
  final gestorPosiciones = ProveedorPosiciones();

  //Ligas
  Future<LigaModel> obtenerAllLigas() => gestorLigas.obtenerListaLigas();

  Future<Liga> obtenerLigaId(String id) => gestorLigas.obtenerLigaId(id);

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

  Future updateCedulaUsuario(String idAntig, String idNew) {
    var resp = gestorUsuarios.anadirSolicitudCedula(idAntig, idNew);
    return resp;
  }

  Future updateNombreUsuario(String id, String nombre) {
    var resp = gestorUsuarios.anadirSolicitudNombre(id, nombre);
    return resp;
  }

  Future updateCorreoUsuario(String id, String correo) {
    var resp = gestorUsuarios.updateCorreoUsuario(id, correo);
    return resp;
  }

  Future updateContrasenaUsuario(String id, String contrasena) {
    var resp = gestorUsuarios.updateContrasenaUsuario(id, contrasena);
    return resp;
  }

  Future updateImageUsuario(String id, String image) {
    var resp = gestorUsuarios.updateImageUsuario(id, image);
    return resp;
  }

//------------Multifunction-----------------------------------
  Future uploadImage(String id, String base64Image, String fileName) {
    var resp = gestorUsuarios.uploadImage(id, base64Image, fileName);
    return resp;
  }

  //Admin
  Future<AdministradorEquipo> obtenerAdminCedula(String cedula) =>
      gestorAdminEquipo.obtenerAdminCedula(cedula);

  Future<AdministradorEquipo> obtenerAdminCorreo(String correo) =>
      gestorAdminEquipo.obtenerAdminCorreo(correo);

  Future updateAdminEquipo(String id, AdministradorEquipo admin) {
    var resp = gestorAdminEquipo.actualizarAdministradorEquipo(id, admin);
    return resp;
  }

  //Jugador
  Future<Jugador> obtenerJugadorCedula(String cedula) =>
      gestorJugadores.obtenerJugadorCedula(cedula);

  Future<Jugador> obtenerJugadorNumero(String numero, String equipo) =>
      gestorJugadores.obtenerJugadorNumero(numero, equipo);

  Future<JugadorModel> obtenerJugadoresEquipo(String idEquipo) =>
      gestorJugadores.obtenerJugadoresEquipo(idEquipo);

  Future insertJugador(String cedula) => gestorJugadores.anadirJugador(cedula);

  Future updateNumeroJugador(String cedula, String numero) =>
      gestorJugadores.updateNumeroJugador(cedula, numero);

  //Equipo
  Future<Equipo> obtenerEquipoNombre(String nombre) =>
      gestorEquipos.obtenerEquipoNombre(nombre);

  Future<Equipo> obtenerEquipoId(String id) =>
      gestorEquipos.obtenerEquipoId(id);

  Future updateNombreEquipo(String idEquipo, String newNombre) {
    var resp = gestorEquipos.updateNombreEquipo(idEquipo, newNombre);
    return resp;
  }

  Future deleteEquipo(String idEquipo) {
    var resp = gestorEquipos.deleteEquipo(idEquipo);
    return resp;
  }

  Future updateImageEquipo(String id, String image) {
    var resp = gestorEquipos.updateImageEquipo(id, image);
    return resp;
  }

  //Partido
  Future<PartidoModel> obtenerProximosPartidos(String idEquipo) =>
      gestorPartidos.obtenerProximosPartidos(idEquipo);

  Future<PartidoModel> obtenerAnterioresPartidos(String idEquipo) =>
      gestorPartidos.obtenerAnterioresPartidos(idEquipo);

  Future prepararDatosPago(String partido, String equipo, String cuota) =>
      gestorPartidos.prepararDatosPago(partido, equipo, cuota);
  //Posiciones
  Future<PosicionModel> obtenerPosiciones(String idLiga) =>
      gestorPosiciones.obtenerPosiciones(idLiga);
}
