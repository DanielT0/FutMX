// Player class model

class Usuario {
  String _cedula;
  String _nombre;
  String _correo;
  String _contrasena;
  String _tipo;

  Usuario(this._cedula, this._nombre, this._correo,this._contrasena, this._tipo); //Constructor

  Usuario.fromJson(Map<String, dynamic> parsedJson) { //Constructor con Json
    this._cedula = parsedJson['idUsuario'];
    this._nombre = parsedJson['Nombre'];
    this._correo = parsedJson['Correo'];
    this._contrasena = parsedJson['Contraseña'];
    this._tipo = parsedJson['idTipoUsuario'];
  }
 //Getters
  String get cedula => this._cedula;
  String get nombre => this._nombre;
  String get correo => this._correo;
  String get contrasena => this._contrasena;
  String get tipo => this._tipo;

 //Setters
  set cedula(String cedula) => this._cedula = cedula;
  set nombre (String nombre) => this._nombre = nombre;
  set correo (String correo) => this._correo =correo;
  set contrasena (String contrasena) => this.contrasena;
  set tipo (String tipo) => this.tipo;
}