// Meeting class model

class PartidoModel {
  List<Partido> _partidos = [];

  PartidoModel(this._partidos);
  
  PartidoModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['partidos'].length);
    List<Partido> temp = [];
    for (int i = 0; i < parsedJson['partidos'].length; i++) {
      Partido partido = Partido(parsedJson['partidos'][i]);
      temp.add(partido);
    }
    _partidos = temp;
  }

  List<Partido> get partidos => _partidos;
}

class Partido {
  String _idPartido;
  String _idEquipoB;
  String _idEquipoA;
  String _fotoEquipoContrario;
  String _nombreEquipoContrario;
  String _ciudad;
  String _ubicacion;
  String _idLiga;
  String _fecha;
  String _hora;
  String _golesEquipoA;
  String _golesEquipoB;
  String _pagoA;
  String _pagoB;

  Partido(resultado){
    this._idLiga=resultado['idLiga'];
    this._idPartido= resultado['idPartido'];
    this._fotoEquipoContrario = resultado['dirFoto'];
    this._nombreEquipoContrario = resultado['Nombre'];
    this._idEquipoB = resultado['idEquipoB'];
    this._idEquipoA = resultado['idEquipoA'];
    this._ciudad = resultado['Ciudad'];
    this._ubicacion = resultado['Direccion'];
    this._idLiga = resultado['idLiga'];
    this._fecha = resultado['Fecha'];
    this._hora = resultado['Hora'];
    this._golesEquipoA = resultado['GolesEquipoA'];
    this._golesEquipoB = resultado['GolesEquipoB'];
    this._pagoA = resultado['PagoA'];
    this._pagoB = resultado['PagoB'];
  } //Constructor

 //Getters


  String get idLiga => this._idLiga;
  String get idPartido => this._idPartido;
  String get fotoEquipoContrario => this._fotoEquipoContrario;
  String get nombreEquipoContrario => this._nombreEquipoContrario;
  String get idEquipoA => this._idEquipoA;
  String get idEquipoB => this._idEquipoB;
  String get ciudad => this._ciudad;
  String get ubicacion => this._ubicacion;
  String get fecha => this._fecha;
  String get hora => this._hora;
  String get golesEquipoA => this._golesEquipoA;
  String get golesEquipoB => this._golesEquipoB;
  String get pagoA => this._pagoA;
  String get pagoB => this._pagoB;

 //Setters
  set idLiga(String idLiga) => this._idLiga = idLiga;
  set idPartido (String idPartido) => this._idPartido = idPartido;
  set nombreEquipoContrario (String nombreEquipoContrario) => this._nombreEquipoContrario =nombreEquipoContrario;
  set fotoEquipoContrario (String foto) => this._fotoEquipoContrario = foto;
  set idEquipoB (String idEquipoB) => this._idEquipoB =idEquipoB;
  set idEquipoA (String idEquipoA) => this._idEquipoA =idEquipoA;
  set ciudad (String ciudad) => this._ciudad =ciudad;
  set ubicacion (String ubicacion) => this._ubicacion =ubicacion;
  set fecha (String fecha) => this._fecha =fecha;
  set hora (String hora) => this._hora =hora;
  set golesEquipoA (String golesEquipoA) => this._golesEquipoA =golesEquipoA;
  set golesEquipoB (String golesEquipoB) => this._golesEquipoB =golesEquipoB;
  set pagoA (String pagoA) => this._pagoA= pagoA;
  set pagoB (String pagoB) => this._pagoB= pagoB;
  }