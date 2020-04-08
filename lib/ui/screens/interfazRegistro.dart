import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/solicitudAdminEquipo.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/models/liga.dart';

import '../Widgets/Inputs.dart';
import '../Widgets/optionInterfazRegistro.dart';
import '../Widgets/buttonSolicitud.dart';

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
  static TextEditingController controllerCorreo = new TextEditingController();
  static TextEditingController controllerNombreEquipo =
      new TextEditingController();
  static TextEditingController controllerNumeroJugador =
      new TextEditingController();
  static TextEditingController controllerContrase = new TextEditingController();
  static TextEditingController controllerConContrase =
      new TextEditingController();

  static TextEditingController controllerIDEquipo = new TextEditingController();

  bool monVal =
      false; //Booleanos declarados para manejar el estado de cada checkbox (sobre días que van a jugar), está seleccionado o no
  bool tuVal = false;
  bool wedVal = false;
  bool thursVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

/**  Y... vamos con las listas, guardan información que varía en widgets que pueden reutilizarse (ahorrando gran parte de código)
 * por ejemplo, las entradas de texto y los botones, que al ser formularios comparten muchas cosas en común, cambiando sólo algunas cosas (como funciones o textos)
*/

  var bloc = new Bloc();

  var opcion = 0;
  var url = 'https://futmxpr.000webhostapp.com/insertSolicitudAdminEquipo.php';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Liga> ligas =
      []; //Lista usada para almacenar las opciones de liga en la interfaz
  List<DropdownMenuItem<Liga>>
      _dropDownMenuItems; //Lista de los dropdowns en la interfaz
  Liga _ligaseleccionada;
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
          'text': 'Correo',
          'controller': controllerCorreo,
          'keyBoardType': TextInputType.text,
          'obscureText': false,
        },
        {
          'text': 'Nombre del Equipo',
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
          'text': 'Correo',
          'controller': controllerCorreo,
          'keyBoardType': TextInputType.text,
          'obscureText': false,
        },
        {
          'text': 'ID del Equipo',
          'controller': controllerIDEquipo,
          'keyBoardType': TextInputType.number,
          'obscureText': false,
        },
        {
          'text': 'Número dentro del equipo',
          'controller': controllerNumeroJugador,
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
   pero no queremos esto con un método que introduce variables a la base de datos, por lo tanto ponemos Future, usado comúnmente para ejecuciones de red
   así flutter sabrá que es un método que será llamado después (el cual es asincrono)
*/
  Future anadirAdministradorEquipo(BuildContext context) async {
    // make POST request
    var ligaSeleccionada = this._ligaseleccionada.idLiga.toString();
    List<String> dias = [];
    if (this.monVal) dias.add('Lunes');
    if (this.tuVal) dias.add('Martes');
    if (this.wedVal) dias.add('Miércoles');
    if (this.thursVal) dias.add('Jueves');
    if (this.friVal) dias.add('Viernes');
    if (this.satVal) dias.add('Sábado');
    if (this.sunVal) dias.add('Domingo');

    var stringDias = dias.toString();
    SolicitudAdministradorEquipo adminEquipo = new SolicitudAdministradorEquipo(
        controllerCedula.text,
        controllerNombre.text,
        controllerCorreo.text,
        controllerNombreEquipo.text,
        ligaSeleccionada,
        stringDias,
        controllerContrase.text);
    this.bloc.addSolicitudAdminEquipo(adminEquipo, context).then(
      (body) {
        print(body);
      },
    );
  }

// Vamos con el camino que se toma para añadir un jugador con el modelo Bloc (es un poco largo pero, vale la pena, y muuuucho) a la base de datos, al presionar el botón "Enviar solicitud", si se está en la interfaz de registro jugador, el sistema viene a este método

  Future anadirJugador(BuildContext context) async {
    SolicitudJugador solicitudJugador = new SolicitudJugador(
        //Primero se crea un objeto de tipo solicitud jugador con el contenido de los controller
        controllerCedula
            .text, //Spoiler... todos son Strings (no sé porqué pero el gestor que está en el servidor sólo reconoce este tipo de datos al hacer requests http)
        controllerNombre.text,
        controllerCorreo.text,
        controllerIDEquipo.text,
        controllerNumeroJugador.text,
        controllerContrase.text);
    this.bloc.addSolicitudJugador(solicitudJugador).then((resp) {
      //Ahora llamamos a nuestro bloc (creado anteriormente), al método "addSolicitudJugador" (vamos para allá a ver que hace... carpeta blocs), usamos then (que devuelve el valor que retornam el método después de que se ejecuta)
      print(resp);
      if (resp == // Validaciones... tomamos cada uno de los errores que nos puede retornar el servidor y asignamos una salida
          "prepare() failed: Cannot add or update a child row: a foreign key constraint fails (`id12947947_futmx`.`solicitudesJugador`, CONSTRAINT `fk_equipoSolicitudJugador` FOREIGN KEY (`Id_Equipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE)") {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('No existe ningún equipo con el ID ingresado'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (resp ==
              ("prepare() failed: Duplicate entry '" +
                  controllerCedula.text +
                  "' for key 'PRIMARY'") ||
          resp ==
              ("prepare() failed: Duplicate entry '" +
                  controllerNombre.text +
                  "' for key 'Nombre_Jugador'")) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Ya existe una solicitud de este jugador'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (resp ==
          ("prepare() failed: Duplicate entry '" +
              controllerNumeroJugador.text +
              "' for key 'fk_unicoNumero'")) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Ya existe una solicitud con ese número de jugador'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (resp ==
          ("prepare() failed: Duplicate entry '" +
              controllerCorreo.text +
              "' for key 'Correo'")) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Ya existe una solicitud con ese correo'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Solicitud enviada'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.obtenerTodasLigas();
  }

  List<DropdownMenuItem<Liga>> buildDropdownMenuItems(List ligas) {
    List<DropdownMenuItem<Liga>> items = List();
    for (Liga liga in ligas) {
      items.add(
        DropdownMenuItem(
          value: liga,
          child: Text(liga.nombre),
        ),
      );
    }
    return items;
  }

  onChangeDropdownMenuItem(Liga liga) {
    setState(() {
      this._ligaseleccionada = liga;
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc.allLigas.map((object) => object.ligas).listen((p) {
      setState(() => ligas = p);
      print(ligas);
      print(ligas[0].nombre);
      this._dropDownMenuItems = buildDropdownMenuItems(this.ligas);
      _ligaseleccionada = _dropDownMenuItems[0].value;
    });
    bloc.allLigas.map((object) => object.ligas[0].nombre).listen(print);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Registrarse')),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            //Formulario, con este podremos hacer validaciones en las casillas input
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
                    }).toList(),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                        children: this.opcion == 0
                            ? <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: const EdgeInsets.only(left: 20),
                                      margin: const EdgeInsets.only(
                                          left: 6, right: 20),
                                      child: Text(
                                        'Liga',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                    DropdownButton(
                                      value: _ligaseleccionada,
                                      items: _dropDownMenuItems,
                                      onChanged: onChangeDropdownMenuItem,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    checkBox("Lunes", monVal),
                                    checkBox("Martes", tuVal),
                                    checkBox("Miércoles", wedVal),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    checkBox("Jueves", thursVal),
                                    checkBox("Viernes", friVal),
                                    checkBox("Sábado", satVal),
                                    checkBox("Domingo", sunVal),
                                  ],
                                ),
                              ]
                            : <Widget>[]),
                  ],
                ),
                buttonSolicitud(() => enviarSolicitud(
                    context)), //Llama al botón asignandole un método (función)
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget checkBox(String title, bool boolValue) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                switch (title) {
                  case "Lunes":
                    monVal = value;
                    break;
                  case "Martes":
                    tuVal = value;
                    break;
                  case "Miércoles":
                    wedVal = value;
                    break;
                  case "Jueves":
                    thursVal = value;
                    break;
                  case "Viernes":
                    friVal = value;
                    break;
                  case "Sábado":
                    satVal = value;
                    break;
                  case "Domingo":
                    sunVal = value;
                    break;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
