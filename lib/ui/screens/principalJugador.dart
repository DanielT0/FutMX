import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/models/posicion.dart';
import 'package:prueba_bd/ui/screens/adminEquipo/interfazEventos.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/tablaPosiciones.dart';

import 'dart:async';

class PrincipalJugador extends StatefulWidget {
  @override
  _principalJugadorState createState() => _principalJugadorState();
}

class _principalJugadorState extends State<PrincipalJugador> {
  int _page = 0;
  String _equipo = "";
  String _textHead = "Eventos";
  GlobalKey _bottomNavigationKey = GlobalKey();
  Bloc bloc = new Bloc();
  Timer
      _temporizador; // Temporizador usado para reconstruir la interfaz cada cierto tiempo
  @override
  void initState() {
    this._page = 0;
    bloc.obtenerSolicitudesJugadorEquipo(_equipo);
    super.initState();
    /**_temporizador = Timer.periodic(
      Duration(seconds: 2),
      (Timer t) {
        if (this.mounted) {
          if (_equipo.isNotEmpty) {
            setState(
              () {
                
              },
            );
          }
        }
      },
    );
    **/
  }

  void _presionaOpcion(int index) {
    setState(
      () {
        _page = index;
        switch (index) {
          case 0:
            _textHead = "Eventos";
            break;
          case 1:
            _textHead = "Posiciones";
            break;
          case 2:
            _textHead = "Perfil";
            break;
          default:
            _textHead= "Eventos";
            break;
        }
      },
    );
  }

  Future eliminarSolicitud(String cedula) async {
    var resp = await this.bloc.deleteSolicitudJugador(cedula);
    print(resp);
  }

  Future aceptarSolicitud(String cedula) async {
    var resp = await this.bloc.addJugador(cedula);
    print(resp);
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    _equipo = myProvider.jugadorUser.equipo;
    bloc.obtenerPosiciones(myProvider.equipo.idLiga);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: AppBar(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(300),
              ),
            ),
            flexibleSpace: Container(
              child: Text(
                _textHead,
                style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.only(left: 70, top: 100),
            ),
          ),
          preferredSize: Size.fromHeight(150)),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 55,
        index: 0,
        buttonBackgroundColor: Colors.green,
        color: Colors.grey[50],
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.event,
            size: 25,
            color: _page == 0 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.table_chart,
            size: 25,
            color: _page == 1 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.portrait,
            size: 25,
            color: _page == 2 ? Colors.white : Colors.green,
          ),
        ],
        onTap: (index) {
          _presionaOpcion(index);
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
            child: Container(
              child: opcionVista(),
            ),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          height: 470,
        ),
      ),
    );
  }

  Widget opcionVista() {
    switch (_page) {
      case 0:
        return InterfazEventosAdmin(); // En la opción 0 (eventos) se mostrarán los partidos a jugar y jugados por el equipo en su respectiva liga
      case 1:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: bloc.posiciones,
            builder: (context, AsyncSnapshot<PosicionModel> snapshot) {
              if (snapshot.hasData) {
                TablaPosiciones tabla = new TablaPosiciones();
                return tabla.buildList(snapshot, context);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      default:
        return Container(
          child: Center(
            child: Text('Trabajando en ello :D '),
          ),
        );
    }
  }
}
