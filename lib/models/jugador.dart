// Player class model

class Jugador {
  String _cedula;
  String _nombre;
  String _correo;
  String _equipo;
  String _numero;
  String _contrasena;

  Jugador(this._cedula, this._nombre, this._correo, this._equipo, this._numero, this._contrasena); //Constructor

 //Getters
  String get cedula => this._cedula;
  String get nombre => this._nombre;
  String get correo => this._correo;
  String get equipo => this._equipo;
  String get numero => this._numero;
  String get contrasena => this._contrasena;

 //Setters
  set cedula(String cedula) => this._cedula = cedula;
  set nombre (String nombre) => this._nombre = nombre;
  set correo (String correo) => this._correo =correo;
  set equipo (String equipo) => this._equipo = equipo;
  set numero(String numero) => this._numero = numero;
  set contrasena (String contrasena) => this.contrasena;
}