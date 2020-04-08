import '../solicitudJugador.dart';
/** 
class GestorSolicitudJugador {

  List<SolicitudJugador> _solicitudes = [];

  GestorSolicitudJugador.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    List<SolicitudJugador> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      SolicitudJugador result = SolicitudJugador(parsedJson['results'][i]);
      temp.add(result);
    }
    this._solicitudes = temp;
  }

  List<SolicitudJugador> get solicitudes => this.solicitudes;
}
*/