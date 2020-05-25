import 'package:flutter/material.dart';
import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/partido.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/ui/Widgets/errorConexion.dart';
import 'package:prueba_bd/ui/Widgets/principalAdmin/proximosPartidos.dart';
import 'package:prueba_bd/ui/Widgets/principalAdmin/anterioresPartidos.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/principalJugador/anterioresPartidos.dart';
import 'package:prueba_bd/ui/screens/adminEquipo/payments.dart';
import 'package:prueba_bd/ui/Widgets/alert.dart';

class InterfazEventosAdmin extends StatefulWidget {
  @override
  _InterfazEventosAdminState createState() => _InterfazEventosAdminState();
}

class _InterfazEventosAdminState extends State<InterfazEventosAdmin>
    with AutomaticKeepAliveClientMixin {
  Bloc bloc = new Bloc();
  Alerta alerta = new Alerta();
  int _opcion;
  EstadoGlobal proveedor;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    this._opcion = 0;
    super.initState();
  }

  void opcion1() {
    setState(() {
      _opcion = 1;
    });
  }

  void opcion0() {
    setState(() {
      _opcion = 0;
    });
  }

  void opcion2() {
    setState(() {
      _opcion = 2;
    });
  }

  void pagarPartido() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => new Payments(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    proveedor = myProvider;
    if (myProvider.tipo == "Jugador") {
      bloc.obtenerProximosPartidos(myProvider.jugadorUser.equipo, context);
      bloc.obtenerAnterioresPartidos(myProvider.jugadorUser.equipo, context);
    } else {
      bloc.obtenerProximosPartidos(
          myProvider.administradorUser.equipo, context);
      bloc.obtenerAnterioresPartidos(
          myProvider.administradorUser.equipo, context);
    }
    return opcionVista();
  }

  Widget opcionVista() {
    switch (_opcion) {
      case 0: // Se ven los n partidos anteriores y próximos del equipo
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: opcion1,
                child: Text(
                  'Próximos partidos',
                  style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              height: 157,
              child: StreamBuilder(
                stream: bloc.proximosPartidos,
                builder: (context,
                    AsyncSnapshot<ApiResponse<PartidoModel>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case Status.COMPLETED:
                        ProximosPartidosList partidos =
                            new ProximosPartidosList(pagarPartido, this.bloc);
                        return partidos.buildList(snapshot, context);
                        break;
                      case Status.ERROR:
                        if (proveedor.tipo == "Jugador") {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerProximosPartidos(
                                  proveedor.jugadorUser.equipo, context),
                              0,
                              20);
                        } else {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerProximosPartidos(
                                  proveedor.administradorUser.equipo, context),
                              0,
                              20);
                        }
                        break;
                    }
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 40,
                child: FlatButton(
                  onPressed: opcion2,
                  child: Text(
                    'Partidos jugados',
                    style: TextStyle(
                        color: Colors.green,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 205,
              child: StreamBuilder(
                stream: bloc.anterioresPartidos,
                builder: (context,
                    AsyncSnapshot<ApiResponse<PartidoModel>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case Status.COMPLETED:
                        if (proveedor.tipo == "Jugador") {
                          AnterioresPartidosJugadorList partidos =
                              new AnterioresPartidosJugadorList();
                          return partidos.buildList(snapshot, context);
                        } else {
                          AnterioresPartidosAdminList partidos =
                              new AnterioresPartidosAdminList();
                          return partidos.buildList(snapshot, context);
                        }
                        break;
                      case Status.ERROR:
                        if (proveedor.tipo == "Jugador") {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerAnterioresPartidos(
                                  proveedor.jugadorUser.equipo, context),
                              50,
                              20);
                        } else {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerAnterioresPartidos(
                                  proveedor.administradorUser.equipo, context),
                              50,
                              20);
                        }
                        break;
                    }
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        );
        break;
      case 1: // se ven todos los próximos partidos en la interfaz
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: opcion0,
                child: Text(
                  'Volver',
                  style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: StreamBuilder(
                stream: bloc.proximosPartidos,
                builder: (context,
                    AsyncSnapshot<ApiResponse<PartidoModel>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case Status.COMPLETED:
                        ProximosPartidosList partidos =
                            new ProximosPartidosList(pagarPartido, this.bloc);
                        return partidos.buildList(snapshot, context);
                        break;
                      case Status.ERROR:
                        if (proveedor.tipo == "Jugador") {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerProximosPartidos(
                                  proveedor.jugadorUser.equipo, context),
                              0,
                              20);
                        } else {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerProximosPartidos(
                                  proveedor.administradorUser.equipo, context),
                              0,
                              20);
                        }
                        break;
                    }
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        );
        break;
      case 2: // Se ven todos los partidos anteriores del equipo
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: opcion0,
                child: Text(
                  'Volver',
                  style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: StreamBuilder(
                stream: bloc.anterioresPartidos,
                builder: (context,
                    AsyncSnapshot<ApiResponse<PartidoModel>> snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                        break;
                      case Status.COMPLETED:
                        if (proveedor.tipo == "Jugador") {
                          AnterioresPartidosJugadorList partidos =
                              new AnterioresPartidosJugadorList();
                          return partidos.buildList(snapshot, context);
                        } else {
                          AnterioresPartidosAdminList partidos =
                              new AnterioresPartidosAdminList();
                          return partidos.buildList(snapshot, context);
                        }
                        break;
                      case Status.ERROR:
                        if (proveedor.tipo == "Jugador") {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerAnterioresPartidos(
                                  proveedor.jugadorUser.equipo, context),
                              50,
                              20);
                        } else {
                          return AlertaError(
                              snapshot.data.message,
                              bloc.obtenerAnterioresPartidos(
                                  proveedor.administradorUser.equipo, context),
                              50,
                              20);
                        }
                        break;
                    }
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        );
        break;
      default:
        return Container(
          child: Center(
            child: Text('Trabajando en ello :D '),
          ),
        );
    }
  }
}
