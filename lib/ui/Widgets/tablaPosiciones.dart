import 'package:flutter/material.dart';

class TablaPosiciones extends StatefulWidget {
  @override
  _TablaPosicionesState createState() => _TablaPosicionesState();
}

class _TablaPosicionesState extends State<TablaPosiciones> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("Posición"),
        ),
        DataColumn(
          label: Text("Equipo"),
        ),
        DataColumn(
          label: Text("Jugados"),
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
      rows: [],
    );
  }
}
