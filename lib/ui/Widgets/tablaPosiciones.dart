import 'package:flutter/material.dart';
import 'package:prueba_bd/models/posicion.dart';

class TablaPosiciones {
  Widget buildList(
      AsyncSnapshot<PosicionModel> snapshot, BuildContext context) {
    return DataTable(
      columnSpacing: 10,
      columns: [
        DataColumn(
          label: Text(
            "Posición",
            textAlign: TextAlign.center,
          ),
        ),
        DataColumn(
          label: Text("Equipo", textAlign: TextAlign.center,),
        ),
        DataColumn(
          label: Text("Partidos Jugados"),
        ),
        DataColumn(
          label: Text("Ganados"),
        ),
        DataColumn(
          label: Text("Empatados"),
        ),
        DataColumn(
          label: Text("Perdidos"),
        ),
        DataColumn(
          label: Text("GF"),
        ),
        DataColumn(
          label: Text("GC"),
        ),
        DataColumn(
          label: Text("DG"),
        ),
        DataColumn(
          label: Text("PTS"),
        ),
      ],
      rows: snapshot.data.posiciones
          .map(
            (posicion) => DataRow(
              cells: [
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      (snapshot.data.posiciones.indexOf(posicion) + 1)
                          .toString(),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 10.0,
                          backgroundImage: NetworkImage(
                              'https://futmxpr.000webhostapp.com/imagenes/' +
                                  posicion.foto),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(posicion.equipo),
                      ],
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.jugados),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.ganados),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.empatados),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.perdidos),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.golesFavor),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.golesContra),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text((int.parse(posicion.golesFavor) -
                            int.parse(posicion.golesContra))
                        .toString()),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(posicion.puntos),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
