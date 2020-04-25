import 'package:flutter/material.dart';
import 'package:prueba_bd/models/partido.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:provider/provider.dart';

class ProximosPartidosList {
  final Function pagar;
  ProximosPartidosList(this.pagar);

  Widget buildList(AsyncSnapshot<PartidoModel> snapshot, BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    return ListView.builder(
      itemCount:
          snapshot.data.partidos.length, //El programa tiene que saber cuantos items ha de mostrar en la lista
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
            margin: EdgeInsets.only(top: 5, bottom: 6),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://futmxpr.000webhostapp.com/imagenes/' +
                              snapshot
                                  .data.partidos[index].fotoEquipoContrario),
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
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        snapshot.data.partidos[index].nombreEquipoContrario,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      snapshot.data.partidos[index].ciudad +
                          ', ' +
                          snapshot.data.partidos[index].ubicacion,
                      style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      snapshot.data.partidos[index].fecha +
                          ', ' +
                          snapshot.data.partidos[index].hora,
                      style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                    ),
                  ],
                ),
                Expanded(
                  child: myProvider.tipo == "Jugador"
                      ? Container()
                      : Column(
                          children: <Widget>[
                            IconButton(
                              iconSize: 32,
                              icon: Icon(Icons.monetization_on),
                              color: Colors.green,
                              tooltip: 'Aceptar solicitud',
                              onPressed: this.pagar,
                            ),
                            Text(
                              'Pagar',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
