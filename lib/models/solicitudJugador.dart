// SolicitudJugador class model
class SolicitudJugadorModel {
  List<SolicitudJugador> _solicitudesJugador = [];

  SolicitudJugadorModel(this._solicitudesJugador);

  SolicitudJugadorModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['solicitudes'].length);
    List<SolicitudJugador> temp = [];
    for (int i = 0; i < parsedJson['solicitudes'].length; i++) {
      SolicitudJugador solicitudJugador =
          SolicitudJugador.json(parsedJson['solicitudes'][i]);
      temp.add(solicitudJugador);
    }
    _solicitudesJugador = temp;
  }

  List<SolicitudJugador> get solicitudesJugador => _solicitudesJugador;
}

class SolicitudJugador {
  String _cedula;
  String _nombre;
  String _correo;
  String _equipo;
  String _numero;
  String _contrasena;

  SolicitudJugador(this._cedula, this._nombre, this._correo, this._equipo,
      this._numero, this._contrasena); //Constructor

  SolicitudJugador.json(resultado) {
    this._cedula = resultado['Cedula_Jugador'];
    this._nombre = resultado['Nombre_Jugador'];
    this._correo = resultado['Correo'];
    this._equipo= resultado['Id_Equipo'];
    this._numero= resultado['Numero'];
    this._contrasena= resultado['Contrasena'];
  } //Constructor

  //Getters
  String get cedula => this._cedula;
  String get nombre => this._nombre;
  String get correo => this._correo;
  String get equipo => this._equipo;
  String get numero => this._numero;
  String get contrasena => this._contrasena;

  //Setters
  set cedula(String cedula) => this._cedula = cedula;
  set nombre(String nombre) => this._nombre = nombre;
  set correo(String correo) => this._correo = correo;
  set equipo(String equipo) => this._equipo = equipo;
  set numero(String numero) => this._numero = numero;
  set contrasena(String contrasena) => this.contrasena;
}
