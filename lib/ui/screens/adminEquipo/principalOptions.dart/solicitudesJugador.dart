import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/errorConexion.dart';
import 'package:prueba_bd/ui/Widgets/solicitudesJugadorList.dart';

class SolicitudesJugador extends StatefulWidget {
  final Bloc bloc;

  SolicitudesJugador(this.bloc);

  @override
  _SolicitudesJugadorState createState() => _SolicitudesJugadorState(this.bloc);
}

class _SolicitudesJugadorState extends State<SolicitudesJugador>
    with AutomaticKeepAliveClientMixin {
  final Bloc bloc;
  EstadoGlobal _proveedor;

  _SolicitudesJugadorState(this.bloc);

  @override
  bool get wantKeepAlive => true;

  Future eliminarSolicitud(String cedula) async {
    var resp = await this.bloc.deleteSolicitudJugador(cedula);
    this.bloc.obtenerSolicitudesJugadorEquipo(
        _proveedor.administradorUser.equipo, context);
    print(resp);
  }

  Future aceptarSolicitud(String cedula) async {
    var resp = await this.bloc.addJugador(cedula);
    this.bloc.obtenerSolicitudesJugadorEquipo(
        _proveedor.administradorUser.equipo, context);
    print(resp);
  }

  @override
  Widget build(BuildContext context) {
    _proveedor = Provider.of<EstadoGlobal>(context, listen: false);
    bloc.obtenerSolicitudesJugadorEquipo(
        _proveedor.administradorUser.equipo, context);
    return StreamBuilder(
      stream: bloc.solicitudesJugadorEquipo,
      builder: (context,
          AsyncSnapshot<ApiResponse<SolicitudJugadorModel>> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
              break;
            case Status.COMPLETED:
              SolicitudesJugadorList jugadores = new SolicitudesJugadorList(
                  this.eliminarSolicitud, this.aceptarSolicitud);

              return jugadores.buildList(snapshot, context);
              break;
            case Status.ERROR:
              return AlertaError(
                  snapshot.data.message,
                  bloc.obtenerSolicitudesJugadorEquipo(
                      _proveedor.administradorUser.equipo, context),
                  70,
                  30);
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
