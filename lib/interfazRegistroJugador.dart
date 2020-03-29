import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './interfazRegistro.dart';

class interfazRegistroJugador extends StatefulWidget {
  @override
  _interfazRegistroJugadorState createState() =>
      _interfazRegistroJugadorState();
}

class _interfazRegistroJugadorState extends State<interfazRegistroJugador> {
  

  TextEditingController controllerCedula = new TextEditingController();
  TextEditingController controllerNombre = new TextEditingController();
  TextEditingController controllerIDEquipo = new TextEditingController();
  TextEditingController controllerContrase = new TextEditingController();
  TextEditingController controllerConContrase = new TextEditingController();

  Future anadirAdministradorCentral() async {
    String url =
        'https://futmxpr.000webhostapp.com/app/insertSolicitudJugador.php';
    // make POST request
    http.Response response = await http.post(url, body: {
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
                    ButtonBar(
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new interfazRegistro(),
                            ),
                          ),
                          child: Text('Administrador de equipo'),
                        ),
                        OutlineButton(
                          onPressed: null,
                          child: Text('Jugador'),
                          color: Colors.green,
                        ),
                        Align(alignment: Alignment.centerLeft),
                      ],
                    ),
                    TextField(
                      controller: controllerCedula,
                      decoration: InputDecoration(hintText: 'Cédula'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: controllerNombre,
                      decoration: InputDecoration(
                          hintText: 'Nombre de usuario',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.red,
                          ))),
                    ),
                    TextField(
                      controller: controllerIDEquipo,
                      decoration: InputDecoration(
                        hintText: 'ID del equipo',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: controllerContrase,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                      ),
                      obscureText: true,
                    ),
                    TextField(
                      controller: controllerConContrase,
                      decoration: InputDecoration(
                        hintText: 'Confirmar contraseña',
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: anadirAdministradorCentral,
                        child: Text(
                          'Enviar solicitud',
                        ),
                        textColor: Colors.white,
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
