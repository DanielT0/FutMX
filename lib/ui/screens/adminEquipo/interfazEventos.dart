import 'package:flutter/material.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/partido.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/ui/Widgets/principalAdmin/proximosPartidos.dart';
import 'package:prueba_bd/ui/Widgets/principalAdmin/anterioresPartidos.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/principalJugador/anterioresPartidos.dart';

class InterfazEventosAdmin extends StatefulWidget {
  @override
  _InterfazEventosAdminState createState() => _InterfazEventosAdminState();
}

class _InterfazEventosAdminState extends State<InterfazEventosAdmin> {
  Bloc bloc = new Bloc();
  int _opcion;
  EstadoGlobal proveedor;

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

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    proveedor = myProvider;
    if (myProvider.tipo == "Jugador") {
      bloc.obtenerProximosPartidos(myProvider.jugadorUser.equipo);
      bloc.obtenerAnterioresPartidos(myProvider.jugadorUser.equipo);
    } else {
      bloc.obtenerProximosPartidos(myProvider.administradorUser.equipo);
      bloc.obtenerAnterioresPartidos(myProvider.administradorUser.equipo);
    }
    return opcionVista();
  }

  Widget opcionVista() {
    switch (_opcion) {
      case 0:
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
              height: 150,
              child: StreamBuilder(
                stream: bloc.proximosPartidos,
                builder: (context, AsyncSnapshot<PartidoModel> snapshot) {
                  if (snapshot.hasData) {
                    ProximosPartidosList partidos =
                        new ProximosPartidosList(() {});
                    return partidos.buildList(snapshot, context);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
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
            SizedBox(
              height: 194,
              child: StreamBuilder(
                stream: bloc.anterioresPartidos,
                builder: (context, AsyncSnapshot<PartidoModel> snapshot) {
                  if (snapshot.hasData) {
                    if (proveedor.tipo == "Jugador") {
                      AnterioresPartidosJugadorList partidos =
                          new AnterioresPartidosJugadorList();
                      return partidos.buildList(snapshot, context);
                    } else {
                      AnterioresPartidosAdminList partidos =
                          new AnterioresPartidosAdminList();
                      return partidos.buildList(snapshot, context);
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
      case 1:
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
                builder: (context, AsyncSnapshot<PartidoModel> snapshot) {
                  if (snapshot.hasData) {
                    ProximosPartidosList partidos =
                        new ProximosPartidosList(() {});
                    return partidos.buildList(snapshot, context);
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
      case 2:
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
                builder: (context, AsyncSnapshot<PartidoModel> snapshot) {
                  if (snapshot.hasData) {
                    if (proveedor.tipo == "Jugador") {
                      AnterioresPartidosJugadorList partidos =
                          new AnterioresPartidosJugadorList();
                      return partidos.buildList(snapshot, context);
                    } else {
                      AnterioresPartidosAdminList partidos =
                          new AnterioresPartidosAdminList();
                      return partidos.buildList(snapshot, context);
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
