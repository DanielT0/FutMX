import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './interfazRegistroJugador.dart';

class interfazRegistro extends StatefulWidget {
  @override
  _interfazRegistroState createState() => _interfazRegistroState();
}

class _interfazRegistroState extends State<interfazRegistro> {
  TextEditingController controllerCedula = new TextEditingController();
  TextEditingController controllerNombre = new TextEditingController();
  TextEditingController controllerNombreEquipo = new TextEditingController();
  TextEditingController controllerContrase = new TextEditingController();
  TextEditingController controllerConContrase = new TextEditingController();

  Future anadirAdministradorCentral() async {
    String url =
        'https://futmxpr.000webhostapp.com/insertSolicitudAdminEquipo.php';
    // make POST request
    http.Response response = await http.post(url, body: {
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
                          onPressed: null,
                          child: Text('Administrador de equipo'),
                        ),
                        OutlineButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new interfazRegistroJugador(),
                            ),
                          ),
                          child: Text('Jugador'),
                          textColor: Colors.green,
                          color: Colors.green,
                        ),
                        Align(alignment: Alignment.centerLeft),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Material(
                        child: TextField(
                          controller: controllerCedula,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Cédula',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Material(
                        child: TextField(
                          controller: controllerNombre,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Nombre de usuario',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Material(
                        child: TextField(
                          controller: controllerNombreEquipo,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Nombre del equipo',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Material(
                        child: TextField(
                          obscureText: true,
                          controller: controllerContrase,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Contraseña',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Material(
                        child: TextField(
                          obscureText: true,
                          controller: controllerConContrase,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Confirmar contraseña',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: RaisedButton(
                    onPressed: anadirAdministradorCentral,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Enviar solicitud',
                    ),
                    textColor: Colors.white,
                    color: Colors.green,
                  ),
                )
              ],
            )));
  }
}
