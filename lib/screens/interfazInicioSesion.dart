import 'package:flutter/material.dart';
import 'package:prueba_bd/Widgets/buttonSolicitud.dart';
import '../Widgets/Inputs.dart';

class interfazInicioSesion extends StatefulWidget {
  @override
  _interfazInicioSesionState createState() => _interfazInicioSesionState();
}

class _interfazInicioSesionState extends State<interfazInicioSesion> {
  static TextEditingController controllerCedula = new TextEditingController();
  static TextEditingController controllerContrase = new TextEditingController();

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
          'text': 'Contraseña',
          'controller': controllerContrase,
          'keyBoardType': TextInputType.text,
          'obscureText': true,
        }
      ]
    }
  ];

  void iniciarSesion(BuildContext context) {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión')),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 140, 0, 0),
        child: Column(
          children: <Widget>[
            Text(
              'Inicia sesión',
              style: TextStyle(
                color: Colors.green,
                fontSize: 35,
                fontWeight: FontWeight.bold,
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
            buttonSolicitud(()=> this.iniciarSesion(context)),
          ],
        ),
      ),
    );
  }
}
