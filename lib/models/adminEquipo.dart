// AdminEquipo class model

import 'package:prueba_bd/models/SolicitudAdminEquipo.dart';

class AdministradorEquipo {
  String _cedula;
  String _nombre;
  String _correo;
  String _equipo;
  String _contrasena;

  AdministradorEquipo(this._cedula, this._nombre, this._correo, this._equipo, this._contrasena); //Constructor

  AdministradorEquipo.fromJson(Map<String, dynamic> parsedJson) {
    this._cedula = parsedJson['Cedula'];
    this._nombre = parsedJson['Nombre'];
    this._correo = parsedJson['Correo'];
    this._equipo = parsedJson['Id_Equipo'];
    this._contrasena = parsedJson['Contraseña'];
  }

 //Getters
  String get cedula => this._cedula;
  String get nombre => this._nombre;
  String get correo => this._correo;
  String get equipo => this._equipo;
  String get contrasena => this._contrasena;

 //Setters
  set cedula(String cedula) => this._cedula = cedula;
  set nombre (String nombre) => this._nombre = nombre;
  set correo (String correo) => this._correo =correo;
  set equipo (String equipo) => this._equipo = equipo;
  set contrasena (String contrasena) => this.contrasena;
}