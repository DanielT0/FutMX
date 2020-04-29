import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/models/equipo.dart';
import 'package:prueba_bd/models/posicion.dart';
import 'package:prueba_bd/ui/screens/adminEquipo/interfazEventos.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/ui/Widgets/solicitudesJugadorList.dart';
import 'package:prueba_bd/ui/Widgets/principalAdmin/jugadoresList.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/tablaPosiciones.dart';

import 'dart:async';

class PrincipalAdmin extends StatefulWidget {
  @override
  _principalAdminState createState() => _principalAdminState();
}

class _principalAdminState extends State<PrincipalAdmin> {
  int _page;
  String _equipo = "";
  String _textHead = "Eventos";
  GlobalKey _bottomNavigationKey = GlobalKey();
  Bloc bloc = new Bloc();
  EstadoGlobal _proveedor;
  Timer
      _temporizador; // Temporizador usado para reconstruir la interfaz cada cierto tiempo
  @override
  void initState() {
    this._page = 0;
    super.initState();
    bloc.obtenerSolicitudesJugadorEquipo(_equipo);
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
    setState(() {
      _page = index;
      switch (index) {
        case 0:
          _textHead = "Eventos";
          break;
        case 1:
          _textHead = "Posiciones";
          break;
        case 2:
          _textHead = "Equipo";
          break;
        case 3:
          _textHead = "Solicitudes";
          break;
        case 4:
          _textHead = "Perfil";
          break;
        default:
      }
    });
  }

  Future eliminarSolicitud(String cedula) async {
    var resp = await this.bloc.deleteSolicitudJugador(cedula);
    this
        .bloc
        .obtenerSolicitudesJugadorEquipo(_proveedor.administradorUser.equipo);
    print(resp);
  }

  Future aceptarSolicitud(String cedula) async {
    var resp = await this.bloc.addJugador(cedula);
    this
        .bloc
        .obtenerSolicitudesJugadorEquipo(_proveedor.administradorUser.equipo);
    print(resp);
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    _equipo = myProvider.administradorUser.equipo;
    _proveedor = myProvider;
    bloc.obtenerPosiciones(_proveedor.equipo.idLiga);
    bloc.obtenerJugadoresEquipo(_equipo);
    bloc.obtenerSolicitudesJugadorEquipo(_proveedor.administradorUser.equipo);
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
            Icons.people,
            size: 25,
            color: _page == 2 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.person_add,
            size: 25,
            color: _page == 3 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.portrait,
            size: 25,
            color: _page == 4 ? Colors.white : Colors.green,
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
      case 2:
        return Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 22,
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            'https://futmxpr.000webhostapp.com/imagenes/' +
                                _proveedor.equipo.foto),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        _proveedor.equipo.nombre,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                ),
              ),
              SizedBox(height: 15,),
              Expanded(
                child: StreamBuilder(
                  stream: bloc.jugadoresEquipo,
                  builder: (context, AsyncSnapshot<JugadorModel> snapshot) {
                    if (snapshot.hasData) {
                      JugadoresList jugadores = new JugadoresList();
                      return jugadores.buildList(snapshot, context);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        );
        break;
      case 3:
        return StreamBuilder(
          stream: bloc.solicitudesJugadorEquipo,
          builder: (context, AsyncSnapshot<SolicitudJugadorModel> snapshot) {
            if (snapshot.hasData) {
              SolicitudesJugadorList jugadores = new SolicitudesJugadorList(
                  this.eliminarSolicitud, this.aceptarSolicitud);
              return jugadores.buildList(snapshot, context);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
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
