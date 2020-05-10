import 'package:flutter/material.dart';
import 'package:prueba_bd/models/partido.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:provider/provider.dart';

class ProximosPartidosList {
  final Function pagar;
  final Bloc bloc;
  ProximosPartidosList(this.pagar, this.bloc);

  Widget buildList(AsyncSnapshot<PartidoModel> snapshot, BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    return ListView.builder(
      itemCount: snapshot.data.partidos
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
            margin: EdgeInsets.only(top: 5, bottom: 6),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://futbolmx1.000webhostapp.com/imagenes/' +
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
                  child: myProvider.tipo ==
                          "Jugador" // Si es jugador retorna un container, si es admin retorna opciones para pagar el partido
                      ? Container()
                      : myProvider.administradorUser
                                  .equipo == // Si el id Es del equipo A se hace validación de pago del mismo
                              snapshot.data.partidos[index].idEquipoA
                          ? Column(
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: snapshot.data.partidos[index].pagoA ==
                                            '0' //Si no está pago, mostrar opción de pago
                                        ? Icon(Icons.monetization_on)
                                        : Icon(Icons.check_box),
                                    color: Colors.green,
                                    tooltip: 'Pagar cuota',
                                    onPressed:
                                        snapshot.data.partidos[index].pagoA ==
                                                '0'
                                            ? () {
                                                myProvider.partido = snapshot
                                                    .data
                                                    .partidos[index]
                                                    .idPartido;
                                                this.pagar();
                                              }
                                            : () => {}),
                                Text(
                                  snapshot.data.partidos[index].pagoA == '0'
                                      ? 'Pagar'
                                      : 'Pago',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              // De lo contrario, se hace con el equipo B
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: snapshot.data.partidos[index].pagoB ==
                                            '0' //Si no está pago, mostrar opción de pago
                                        ? Icon(Icons.monetization_on)
                                        : Icon(Icons.check_box),
                                    color: Colors.green,
                                    tooltip: 'Pagar cuota',
                                    onPressed:
                                        snapshot.data.partidos[index].pagoB ==
                                                '0'
                                            ? () {
                                                myProvider.partido = snapshot
                                                    .data
                                                    .partidos[index]
                                                    .idPartido;
                                                this.pagar();
                                              }
                                            : () => {}),
                                Text(
                                  snapshot.data.partidos[index].pagoB == '0'
                                      ? 'Pagar'
                                      : 'Pago',
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
