import 'package:flutter/foundation.dart';
import 'package:prueba_bd/models/equipo.dart';

import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/models/adminEquipo.dart';

// Último cambio dado por Daniel Torres 

/**
 * Los clases provider son usadas para guardar información que se comparte entre uno o más Widgets de nuestro árbol
 * sin importar su nivel, estas actúan con la clase ChangeNotifier, para que los Widgets puedan acceder a ella y
 * cambiar variables que son usadas por los demás
 */
class EstadoGlobal with ChangeNotifier {
//Creamos una claSe "EstadoGlobal" y le agregamos las capacidades de Change Notifier.
Jugador _userJugador;      //Objeto que representa al jugador que ha iniciado sesión
AdministradorEquipo _userAdmin;     //Objeto que representa al admin que ha iniciado sesión
String _tipo;
Equipo _equipo;

String get tipo => _tipo;              //Con él sabremos qué tipo de usuario está navegando

set tipo(String tipo){
  _tipo= tipo;
  notifyListeners();
}

Jugador get jugadorUser => _userJugador;    

set jugadorUser(Jugador newJugador){
_userJugador= newJugador;
notifyListeners();
}

AdministradorEquipo get administradorUser => _userAdmin;

set administradorUser(AdministradorEquipo newAdmin){
_userAdmin= newAdmin;
notifyListeners();
}

Equipo get equipo => _equipo;

set equipo(Equipo equipo){
  _equipo = equipo;
  notifyListeners();
}

int _usuario = null; //Dentro de nuestro provider, creamos e inicializamos nuestra variable. En este caso un int correspondiente a la cédula del usuario que está activo
int get usuario => _usuario; //Creamos el método Get, para poder obtener el valor de mitexto
//Ahora creamos el método set para poder actualizar el valor de _mitexto, este método recibe un valor newTexto de tipo String
set usuario(int newUsuario) {
_usuario = newUsuario; //actualizamos el valor
notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
}

}