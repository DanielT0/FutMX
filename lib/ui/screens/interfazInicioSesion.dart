import 'package:flutter/material.dart';
import 'package:prueba_bd/ui/Widgets/buttonSolicitud.dart';
import 'package:prueba_bd/ui/screens/principalAdmin.dart';
import '../Widgets/Inputs.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';

import 'package:prueba_bd/blocs/bloc.dart';
import 'package:provider/provider.dart';

var bloc = new Bloc();
final _scaffoldKey = new GlobalKey<ScaffoldState>();

class interfazInicioSesion extends StatefulWidget {
  @override
  _interfazInicioSesionState createState() => _interfazInicioSesionState();
}

class _interfazInicioSesionState extends State<interfazInicioSesion> {
  static TextEditingController controllerCorreo = new TextEditingController();
  static TextEditingController controllerContrase = new TextEditingController();

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

  void iniciarSesion(BuildContext context) async {
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
      var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
      if (myProvider.tipo == "Administrador Equipo") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => new principalAdmin(),
          ),
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Trabajando en interfaz de jugador'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    .map((input) {
                  return Inputs(
                      input['text'],
                      input['controller'],
                      input['keyBoardType'],
                      input['obscureText']); //Inputs con parámetros
                }).toList(),
                buttonSolicitud(
                  () => this.iniciarSesion(context), "Iniciar sesión"
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
