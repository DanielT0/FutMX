import 'package:flutter/foundation.dart';

// Último cambio dado por Daniel Torres 

/**
 * Los clases provider son usadas para guardar información que se comparte entre uno o más Widgets de nuestro árbol
 * sin importar su nivel, estas actúan con la clase ChangeNotifier, para que los Widgets puedan acceder a ella y
 * cambiar variables que son usadas por los demás
 */
class EstadoGlobal with ChangeNotifier {
//Creamos una claSe "EstadoGlobal" y le agregamos las capacidades de Change Notifier.

int _usuario = null; //Dentro de nuestro provider, creamos e inicializamos nuestra variable. En este caso un int correspondiente a la cédula del usuario que está activo
int get usuario => _usuario; //Creamos el método Get, para poder obtener el valor de mitexto
//Ahora creamos el método set para poder actualizar el valor de _mitexto, este método recibe un valor newTexto de tipo String
set usuario(int newUsuario) {
_usuario = newUsuario; //actualizamos el valor
notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
}
}