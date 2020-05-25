// Player class model

class JugadorModel {
  List<Jugador> _jugadores = [];

  JugadorModel(this._jugadores);

  JugadorModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['jugadores'].length);
    List<Jugador> temp = [];
    for (int i = 0; i < parsedJson['jugadores'].length; i++) {
      Jugador jugador =
          Jugador.fromJson(parsedJson['jugadores'][i]);
      temp.add(jugador);
    }
    _jugadores = temp;
  }

  List<Jugador> get jugadores => _jugadores;
}

class Jugador {
  String _cedula;
  String _nombre;
  String _correo;
  String _equipo;
  String _numero;
  String _contrasena;
  String _foto;

  Jugador(this._cedula, this._nombre, this._correo, this._equipo, this._numero, this._contrasena, this._foto); //Constructor

  Jugador.fromJson(Map<String, dynamic> parsedJson) { //Constructor con Json
    this._cedula = parsedJson['Cedula'];
    this._nombre = parsedJson['Nombre'];
    this._correo = parsedJson['Correo'];
    this._equipo = parsedJson['Id_Equipo'];
    this._numero = parsedJson['Numero'];
    this._contrasena = parsedJson['Contraseña'];
    this._foto=parsedJson['Foto'];
  }
 //Getters
  String get cedula => this._cedula;
  String get nombre => this._nombre;
  String get correo => this._correo;
  String get equipo => this._equipo;
  String get numero => this._numero;
  String get contrasena => this._contrasena;
  String get foto => this._foto;

 //Setters
  set cedula(String cedula) => this._cedula = cedula;
  set nombre(String nombre) => this._nombre = nombre;
  set correo(String correo) => this._correo =correo;
  set equipo(String equipo) => this._equipo = equipo;
  set numero(String numero) => this._numero = numero;
  set contrasena(String contrasena) => this._contrasena = contrasena;
  set foto(String foto) => this._foto = foto;
}