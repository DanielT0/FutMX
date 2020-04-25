import 'package:flutter/material.dart';

class optionInterfazRegistro extends StatelessWidget {
  final Function cambiaInterfaz;
  final int opcion;

  optionInterfazRegistro(this.cambiaInterfaz,
      this.opcion); //Maneja las opciones principales de la interfaz, con opción se elige la interfaz a mostrar (0= admin, 1=Jugador)
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: this.opcion == 0
              ? <Widget>[
                  RaisedButton(
                    onPressed: null,
                    child: Text('Administrador de equipo'),
                    color: Colors.white,
                    disabledColor: Colors.transparent,
                    disabledTextColor: Colors.green,
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () => this.cambiaInterfaz(1),
                      child: Text('Jugador'),
                      textColor: Colors.white,
                      color: Colors.green,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  ),
                  Align(alignment: Alignment.centerLeft),
                ]
              : <Widget>[
                  RaisedButton(
                    onPressed: () => this.cambiaInterfaz(0),
                    child: Text('Administrador de equipo'),
                    textColor: Colors.white,
                    color: Colors.green,
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text('Jugador'),
                    color: Colors.white,
                    disabledColor: Colors.transparent,
                    disabledTextColor: Colors.green,
                  ),
                  Align(alignment: Alignment.centerLeft),
                ]),
    );
  }
}
