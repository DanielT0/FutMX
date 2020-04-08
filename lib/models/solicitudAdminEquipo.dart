// SolicitudAdminEquipo class model

class SolicitudAdministradorEquipo {
  String _cedula;
  String _nombre;
  String _correo;
  String _equipo;
  String _liga;
  String _dias;
  String _contrasena;

  SolicitudAdministradorEquipo(this._cedula, this._nombre, this._correo, this._equipo, this._liga, this._dias, this._contrasena); //Constructor

 //Getters
  String get cedula => this._cedula;
  String get nombre => this._nombre;
  String get correo => this._correo;
  String get equipo => this._equipo;
  String get liga => this._liga;
  String get dias => this._dias;
  String get contrasena => this._contrasena;

 //Setters
  set cedula(String cedula) => this._cedula = cedula;
  set nombre (String nombre) => this._nombre = nombre;
  set correo (String correo) => this._correo =correo;
  set equipo (String equipo) => this._equipo = equipo;
  set numero(String liga) => this._liga= liga;
  set dias(String dias) => this._dias=dias;
  set contrasena (String contrasena) => this.contrasena;
}