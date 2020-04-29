// Meeting class model

class PosicionModel {
  List<Posicion> _posiciones = [];

  PosicionModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['posiciones'].length);
    List<Posicion> temp = [];
    for (int i = 0; i < parsedJson['posiciones'].length; i++) {
      Posicion posicion = Posicion(parsedJson['posiciones'][i]);
      temp.add(posicion);
    }
    _posiciones = temp;
  }

  List<Posicion> get posiciones => _posiciones;
}

class Posicion {
  String _equipo;
  String _jugados;
  String _ganados;
  String _empatados;
  String _perdidos;
  String _golesFavor;
  String _golesContra;
  String _puntos;
  String _foto;

  Posicion(resultado){
    this._equipo= resultado['Nombre'];
    this._jugados = resultado['Jugados'];
    this._ganados = resultado['Ganados'];
    this._empatados = resultado['Empatados'];
    this._perdidos = resultado['Perdidos'];
    this._golesFavor = resultado['GolesFavor'];
    this._golesContra = resultado['GolesContra'];
    this._puntos = resultado['Puntos'];
    this._foto = resultado['dirFoto'];
  } //Constructor

 //Getters


  String get equipo => this._equipo;
  String get jugados => this._jugados;
  String get ganados => this._ganados;
  String get empatados => this._empatados;
  String get perdidos => this._perdidos;
  String get golesFavor => this._golesFavor;
  String get golesContra => this._golesContra;
  String get puntos => this._puntos;
  String get foto => this._foto;

 //Setters
  set equipo(String equipo) => this._equipo = equipo;
  set jugados(String jugados) => this._jugados = jugados;
  set ganados(String ganados) => this._ganados =ganados;
  set empatados(String empatados) => this._empatados = empatados;
  set perdidos(String perdidos) => this._perdidos =perdidos;
  set golesFavor(String golesFavor) => this._golesFavor =golesFavor;
  set golesContra(String golesContra) => this._golesContra =golesContra;
  set puntos(String puntos) => this._puntos =puntos;
  set foto(String foto)=> this._foto = foto;
}