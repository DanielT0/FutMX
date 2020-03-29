import 'package:flutter/material.dart';

class optionInterfazRegistro extends StatelessWidget {

  final Function cambiaInterfaz;
  final int opcion;

  optionInterfazRegistro(this.cambiaInterfaz, this.opcion);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonBar(
        children: this.opcion==0 ?
        <Widget>[
          OutlineButton(
            onPressed: null,
            child: Text('Administrador de equipo'),
          ),
          OutlineButton(
            onPressed:()=>this.cambiaInterfaz(1),
            child: Text('Jugador'),
            textColor: Colors.green,
            color: Colors.green,
          ),
          Align(alignment: Alignment.centerLeft),
        ]
        :
        <Widget>[
          OutlineButton(
            onPressed: ()=> this.cambiaInterfaz(0),
            child: Text('Administrador de equipo'),
          ),
          OutlineButton(
            onPressed:null,
            child: Text('Jugador'),
            textColor: Colors.green,
            color: Colors.green,
          ),
          Align(alignment: Alignment.centerLeft),
        ]
      ),
    );
  }
}
