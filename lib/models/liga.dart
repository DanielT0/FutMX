// Player class model
class LigaModel {
  List<Liga> _ligas = [];

  LigaModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['ligas'].length);
    List<Liga> temp = [];
    for (int i = 0; i < parsedJson['ligas'].length; i++) {
      Liga liga = Liga(parsedJson['ligas'][i]);
      temp.add(liga);
    }
    _ligas = temp;
  }

  List<Liga> get ligas => _ligas;
}

class Liga {
  String _idLiga;
  String _nombre;
  String _precio;

  Liga(resultado){
    this._idLiga=resultado['idLiga'];
    this._nombre= resultado['NombreLiga'];
    this._precio=resultado['PrecioArbitraje'];
  } //Constructor

 //Getters
  String get idLiga => this._idLiga;
  String get nombre => this._nombre;
  String get precio => this._precio;

 //Setters
  set idLiga(String idLiga) => this._idLiga = idLiga;
  set nombre (String nombre) => this._nombre = nombre;
  set precio (String precio) => this._precio =precio;
}