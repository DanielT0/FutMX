import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/models/posicion.dart';

class TablaPosiciones {
  Widget buildList(AsyncSnapshot<ApiResponse<PosicionModel>> snapshot,
      BuildContext context) {
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
          label: Text(
            "Equipo",
            textAlign: TextAlign.center,
          ),
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
      rows: snapshot.data.data.posiciones
          .map(
            (posicion) => DataRow(
              cells: [
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      (snapshot.data.data.posiciones.indexOf(posicion) + 1)
                          .toString(),
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl:
                              'https://futbolmx1.000webhostapp.com/imagenes/' +
                                  posicion.foto,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          posicion.equipo,
                          style: TextStyle(
                              color: snapshot.data.data.posiciones
                                          .indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.jugados,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.ganados,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.empatados,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.perdidos,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.golesFavor,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.golesContra,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      (int.parse(posicion.golesFavor) -
                              int.parse(posicion.golesContra))
                          .toString(),
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      posicion.puntos,
                      style: TextStyle(
                          color:
                              snapshot.data.data.posiciones.indexOf(posicion) <
                                      8
                                  ? Colors.green
                                  : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
