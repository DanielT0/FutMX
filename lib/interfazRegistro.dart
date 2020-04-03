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
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
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
              'https://futmxpr.000webhostapp.com/app/insertSolicitudAdminEquipo.php' // Sentencia ? : (reemplaza el if else)
          : this.url =
              'https://futmxpr.000webhostapp.com/app/insertSolicitudJugador2.php';
    });
  }

  void enviarSolicitud(BuildContext context) {
    if (controllerConContrase.text != controllerContrase.text) {
      print('Las contraseñas no coinciden');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Las contraseñas no coinciden'),
        backgroundColor: Colors.red,
      ));
    }
    // Validate devolverá true si el formulario es válido, o false si
    // el formulario no es válido.
    else if (_formKey.currentState.validate()) {
      // Si el formulario es válido, muestre un snackbar. En el mundo real, a menudo
      // desea llamar a un servidor o guardar la información en una base de datos
      this.opcion == 0
          ? this.anadirAdministradorEquipo(context)
          : this.anadirJugador(context);
    }
  }

/** Para entender este método se debe tener en cuenta que Flutter ejecuta los métodos apenas se "construye" la página
   pero no queremos esto con un método que introduce variables a la base de datos, por lo tanto ponemos Future,
   así flutter sabrá que es un método que será llamado después (el cual es asincrono)
*/
  Future anadirAdministradorEquipo(BuildContext context) async {
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
    if (body != "") {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ya existe una solicitud de este usuario'),
        backgroundColor: Colors.red,
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Solicitud enviada'),
        backgroundColor: Colors.green,
      ));
    }
  }

  Future anadirJugador(BuildContext context) async {
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
    if (body == "prepare() failed: Cannot add or update a child row: a foreign key constraint fails (`id12947947_futmx`.`solicitudesJugador`, CONSTRAINT `fk_equipoSolicitudJugador` FOREIGN KEY (`Id_Equipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE)") {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No existe ningún equipo con el ID ingresado'),
        backgroundColor: Colors.red,
      ));
    } 
    else if(body == ("prepare() failed: Duplicate entry '"+controllerCedula.text+"' for key 'PRIMARY'")){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Ya existe una solicitud de este jugador'),
        backgroundColor: Colors.red,
      ));
    }
    else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Solicitud enviada'),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Registrarse')),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    optionInterfazRegistro(_presionaOpcion, opcion),
                    ...(_inputsText[opcion]['inputsText']
                            as List<Map<String, Object>>)
                        .map((input) {
                      return Inputs(
                          input['text'],
                          input['controller'],
                          input['keyBoardType'],
                          input['obscureText']); //Inputs con parámetros
                    }).toList()
                  ],
                ),
                buttonSolicitud(() => enviarSolicitud(
                    context)) //Llama al botón asignandole un método (función)
              ],
            ),
          ),
        );
      }),
    );
  }
}
