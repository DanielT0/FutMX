import 'package:flutter/material.dart';
import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/models/jugador.dart';

class JugadoresList {
  JugadoresList();

  Widget buildList(AsyncSnapshot<ApiResponse<JugadorModel>> snapshot, BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: snapshot.data.data.jugadores
          .length, //El programa tiene que saber cuantos items ha de mostrar en la lista
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 3.0),
            ],
          ),
          child: Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      snapshot.data.data.jugadores[index].numero,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: Text(
                        snapshot.data.data.jugadores[index].nombre,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      snapshot.data.data.jugadores[index].correo,
                      style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      snapshot.data.data.jugadores[index].cedula,
                      style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
