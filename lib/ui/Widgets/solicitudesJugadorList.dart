import 'package:flutter/material.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SolicitudesJugadorList {
  final Function eliminarSolicitud;
  final Function aceptarSolicitud;

  SolicitudesJugadorList(this.eliminarSolicitud, this.aceptarSolicitud);

  Widget buildList(
      AsyncSnapshot<SolicitudJugadorModel> snapshot, BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.solicitudesJugador
          .length, //El programa tiene que saber cuantos items ha de mostrar en la lista
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          // Show a red background as the item is swiped away.
          background: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Aceptar",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          key: Key(snapshot.data.solicitudesJugador[index].cedula.toString()),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              this.eliminarSolicitud(
                  snapshot.data.solicitudesJugador[index].cedula);
              return Alert(
                      context: context,
                      title: "Solicitud eliminada",
                      buttons: [
                        DialogButton(
                          color: Colors.red,
                          child: Text(
                            "Okay",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                      type: AlertType.info,
                      desc: "")
                  .show();
            }
            else {
              this.aceptarSolicitud(
                  snapshot.data.solicitudesJugador[index].cedula);
              return Alert(
                      context: context,
                      title: "Solicitud aceptada",
                      buttons: [
                        DialogButton(
                          color: Colors.green,
                          child: Text(
                            "Okay",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                      type: AlertType.info,
                      desc: "")
                  .show();
            }
          },
          child: Container(
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
                      Text("ID "+snapshot.data.solicitudesJugador[index].cedula,
                          style:
                              TextStyle(fontSize: 11, color: Colors.blueGrey)),
                    ],
                  ),
                  Expanded(
                    child: IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.check_circle_outline),
                      color: Colors.green,
                      tooltip: 'Aceptar solicitud',
                      onPressed: () {
                        this.aceptarSolicitud(
                            snapshot.data.solicitudesJugador[index].cedula);
                        return Alert(
                                context: context,
                                title: "Solicitud aceptada",
                                type: AlertType.success,
                                desc: "")
                            .show();
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      tooltip: 'Eliminar solicitud',
                      onPressed: () {
                        this.eliminarSolicitud(
                            snapshot.data.solicitudesJugador[index].cedula);
                        return Alert(
                                context: context,
                                title: "Solicitud eliminada",
                                buttons: [
                                  DialogButton(
                                    color: Colors.red,
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                                type: AlertType.info,
                                desc: "")
                            .show();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
