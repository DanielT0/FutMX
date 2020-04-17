import 'package:flutter/material.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';

class SolicitudesJugadorList {
  Widget buildList(AsyncSnapshot<SolicitudJugadorModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.solicitudesJugador
          .length, //El programa tiene que saber cuantos items ha de mostrar en la lista
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 3.0),
            ],
          ),
          child: Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      snapshot.data.solicitudesJugador[index].numero,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: Text(
                        snapshot.data.solicitudesJugador[index].nombre,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(snapshot.data.solicitudesJugador[index].cedula,
                        style: TextStyle(fontSize: 11, color: Colors.blueGrey)),
                  ],
                ),
                Expanded(
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.check_circle_outline),
                    color: Colors.green,
                    tooltip: 'Aceptar solicitud',
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    tooltip: 'Eliminar solicitud',
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
