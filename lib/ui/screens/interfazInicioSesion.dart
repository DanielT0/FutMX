import 'package:flutter/material.dart';
import 'package:prueba_bd/ui/Widgets/buttonSolicitud.dart';
import 'package:prueba_bd/ui/screens/adminEquipo/principalAdmin.dart';
import 'package:prueba_bd/ui/screens/jugador/principalJugador.dart';
import '../Widgets/Inputs.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:prueba_bd/ui/Widgets/alert.dart';

import 'package:prueba_bd/blocs/bloc.dart';
import 'package:provider/provider.dart';

var bloc = new Bloc();
var alerta = new Alerta();
final _scaffoldKey = new GlobalKey<ScaffoldState>();
EstadoGlobal _myProvider;

class interfazInicioSesion extends StatefulWidget {
  @override
  _interfazInicioSesionState createState() => _interfazInicioSesionState();
}

class _interfazInicioSesionState extends State<interfazInicioSesion> {
  static TextEditingController controllerCorreo =
      new TextEditingController(text: '');
  static TextEditingController controllerContrase =
      new TextEditingController(text: '');

  final _inputsText = [
    {
      'buttonSubmit': 'Enviar solicitud', //texto que aparecerá en el botón
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Correo', //Texto del input
          'controller':
              controllerCorreo, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.text, //Tipo de texto ingresado
          'obscureText': false, //obscureText ... Para contraseñas
        },
        {
          'text': 'Contraseña',
          'controller': controllerContrase,
          'keyBoardType': TextInputType.text,
          'obscureText': true,
        }
      ]
    }
  ];

  //--------------------------- Métodos --------------------------------------
  @override
  void initState() {
    super.initState();
  }

  void mostrarError() {
    alerta.showAlert(
        context,
        "No eres tú, somos nosotros",
        "Entiendo",
        "Se ha dado un error en la conexión con el servidor, por favor, intentalo de nuevo",
        Colors.red,
        () {});
  }

  Future iniciarSesion(BuildContext context) async {
    try {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Estableciendo conexión...'),
          backgroundColor: Colors.green,
        ),
      );
      var resp = await bloc.iniciarSesion(
          // En bloc pusimos que si el usuario y contraseña estaban bien se devolvía true, de lo contrario, false
          controllerCorreo.text,
          controllerContrase.text,
          context);
      if (!resp) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuario o contraseña incorrectos'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        _myProvider.errorServidor = false;
        if (_myProvider.tipo == "Jugador") {
          Navigator.pushNamed(context, '/InicioSesion/PrincipalJugador');
        } else {
          Navigator.pushNamed(context, '/InicioSesion/PrincipalAdmin');
        }
      }
    } on Exception {
      Alert(
              context: context,
              title: 'Uh-oh',
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
              type: AlertType.error,
              desc:
                  'Hubo un error de conexión, revisa tu conexión a internet e inténtalo de nuevo')
          .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    _myProvider = Provider.of<EstadoGlobal>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Iniciar sesión')),
      body: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Inicia sesión',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                ...(_inputsText[0]['inputsText'] as List<Map<String, Object>>)
                    .map(
                  (input) {
                    return Inputs(
                      input['text'],
                      input['controller'],
                      input['keyBoardType'],
                      input['obscureText'],
                    ); //Inputs con parámetros
                  },
                ).toList(),
                buttonSolicitud(
                    () => this.iniciarSesion(context), "Iniciar sesión"),
              ],
            ),
          );
        },
      ),
    );
  }
}
