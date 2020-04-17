// Team class model

class Equipo {
  String _idEquipo;
  String _nombre;
  String _idLiga;
  String _foto;

 Equipo(this._idEquipo, this._nombre, this._idLiga, this._foto); //Constructor

 Equipo.fromJson(Map<String, dynamic> parsedJson) {
    this._idEquipo = parsedJson['idEquipo'];
    this._nombre = parsedJson['Nombre'];
    this._idLiga = parsedJson['idLiga'];
    this._foto = "parsedJson['Id_Equipo']";
  }

 //Getters
  String get idEquipo => this._idEquipo;
  String get nombre => this._nombre;
  String get idLiga => this._idLiga;
  String get foto => this._foto;

 //Setters
  set idEquipo(String idEquipo) => this._idEquipo = idEquipo;
  set nombre (String nombre) => this._nombre = nombre;
  set idLiga (String idLiga) => this._idLiga =idLiga;
  set foto (String foto) => this._foto = foto;
}