import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/posicion.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/errorConexion.dart';
import 'package:prueba_bd/ui/Widgets/tablaPosiciones.dart';

class InterfazPosiciones extends StatefulWidget {
  final Bloc bloc;

  InterfazPosiciones(this.bloc);

  @override
  _InterfazPosicionesState createState() => _InterfazPosicionesState();
}

class _InterfazPosicionesState extends State<InterfazPosiciones>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var proveedor = Provider.of<EstadoGlobal>(context, listen: false);
    bloc.obtenerPosiciones(proveedor.equipo.idLiga, context);
    return StreamBuilder(
      stream: bloc.posiciones,
      builder: (context, AsyncSnapshot<ApiResponse<PosicionModel>> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
              break;
            case Status.COMPLETED:
              TablaPosiciones tabla = TablaPosiciones();
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: tabla.buildList(snapshot, context),
                ),
              );
              break;
            case Status.ERROR:
              return AlertaError(snapshot.data.message,
                  bloc.obtenerPosiciones(proveedor.equipo.idLiga, context), 80, 30);
              break;
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
