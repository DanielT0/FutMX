import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Widgets/Inputs.dart';
import './Widgets/optionInterfazRegistro.dart';
import './Widgets/buttonSolicitud.dart';

class interfazRegistro extends StatefulWidget {
  //StatefulWidget: Permite el cambio de elementos de los widgets
  @override
  _interfazRegistroState createState() => _interfazRegistroState();
}

class _interfazRegistroState extends State<interfazRegistro> {
  //State: determina el estado en que se encuentran los widgets
  static TextEditingController controllerCedula =
      new TextEditingController(); // Maneja los datos ingresados por el input de Cedula
  static TextEditingController controllerNombre = new TextEditingController();
  static TextEditingController controllerNombreEquipo =
      new TextEditingController();
  static TextEditingController controllerContrase = new TextEditingController();
  static TextEditingController controllerConContrase =
      new TextEditingController();

  static TextEditingController controllerIDEquipo = new TextEditingController();

/**  Y... vamos con las listas, guardan información que varía en widgets que pueden reutilizarse (ahorrando gran parte de código)
 * por ejemplo, las entradas de texto y los botones, que al ser formularios comparten muchas cosas en común, cambiando sólo algunas cosas (como funciones o textos)
*/

  var opcion = 0;
  var url = 'https://futmxpr.000webhostapp.com/insertSolicitudAdminEquipo.php';
  final _inputsText = [
    {
      'buttonSubmit': 'Enviar solicitud', //texto que aparecerá en el botón
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Cedula', //Texto del input
          'controller':
              controllerCedula, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.number, //Tipo de texto ingresado
          'obscureText': false, //obscureText ... Para contraseñas
        },
        {
          'text': 'Nombre',
          'controller': controllerNombre,
          'keyBoardType': TextInputType.text,
          'obscureText': false,
        },
        {
          'text': 'NombreEquipo',
          'controller': controllerNombreEquipo,
          'keyBoardType': TextInputType.text,
          'obscureText': false,
        },
        {
          'text': 'Contraseña',
          'controller': controllerContrase,
          'keyBoardType': TextInputType.text,
          'obscureText': true,
        },
        {
          'text': 'Confirmar Contraseña',
          'controller': controllerConContrase,
          'keyBoardType': TextInputType.text,
          'obscureText': true,
        }
      ]
    },
    {
      'buttonSubmit': 'Enviar solicitud',
      'inputsText': [
        {
          'text': 'Cedula',
          'controller': controllerCedula,
          'keyBoardType': TextInputType.number,
          'obscureText': false,
        },
        {
          'text': 'Nombre',
          'controller': controllerNombre,
          'keyBoardType': TextInputType.text,
          'obscureText': false,
        },
        {
          'text': 'ID Equipo',
          'controller': controllerIDEquipo,
          'keyBoardType': TextInputType.number,
          'obscureText': false,
        },
        {
          'text': 'Contraseña',
          'controller': controllerContrase,
          'keyBoardType': TextInputType.text,
          'obscureText': true,
        },
        {
          'text': 'Confirmar Contraseña',
          'controller': controllerConContrase,
          'keyBoardType': TextInputType.text,
          'obscureText': true,
        }
      ]
    }
  ];

  void _presionaOpcion(int option) {
    setState(() {
      this.opcion = option;
      option == 0
          ? this.url =
              'https://futmxpr.000webhostapp.com/insertSolicitudAdminEquipo.php' // Sentencia ? : (reemplaza el if else)
          : this.url =
              'https://futmxpr.000webhostapp.com/app/insertSolicitudJugador.php';
    });
  }

  void enviarSolicitud() {
    this.opcion == 0 ? this.anadirAdministradorEquipo() : this.anadirJugador();
  }

/** Para entender este método se debe tener en cuenta que Flutter ejecuta los métodos apenas se "construye" la página
   pero no queremos esto con un método que introduce variables a la base de datos, por lo tanto ponemos Future,
   así flutter sabrá que es un método que será llamado después (el cual es asincrono)
*/
  Future anadirAdministradorEquipo() async {
    // make POST request
    http.Response response = await http.post(this.url, body: {
      "Cedula": controllerCedula.text,
      "Nombre": controllerNombre.text,
      "NombreEquipo": controllerNombreEquipo.text,
      "Contraseña": controllerContrase.text
    });
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
    print(statusCode);
    print(body);
  }

  Future anadirJugador() async {
    // make POST request
    http.Response response = await http.post(this.url, body: {
      "Cedula": controllerCedula.text,
      "Nombre": controllerNombre.text,
      "Equipo": controllerIDEquipo.text,
      "Contraseña": controllerContrase.text
    });
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
    print(statusCode);
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                optionInterfazRegistro(_presionaOpcion, opcion),
                ...(_inputsText[opcion]['inputsText']
                        as List<Map<String, Object>>)
                    .map((input) {
                  return Inputs(input['text'], input['controller'],
                      input['keyBoardType'], input['obscureText']);
                }).toList()
              ],
            ),
            buttonSolicitud(enviarSolicitud)
          ],
        ),
      ),
    );
  }
}
