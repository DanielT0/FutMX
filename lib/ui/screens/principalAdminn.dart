import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:async';

import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/solicitudJugador.dart';
import 'package:prueba_bd/ui/Widgets/solicitudesJugadorList.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class principalAdminn extends StatefulWidget {
  @override
  _principalAdminnState createState() => _principalAdminnState();
}

class _principalAdminnState extends State<principalAdminn> {
  int _page = 0;
  String _textHead = "";
  GlobalKey _bottomNavigationKey = GlobalKey();
  Bloc bloc = new Bloc();
  SolicitudesJugadorList jugadores = new SolicitudesJugadorList();
  Timer _temporizador;
  @override
  void initState() {
    super.initState();
    _page = 0;
    _temporizador = Timer.periodic(
      Duration(seconds: 5),
      (Timer t) {
        if (this.mounted) {
          setState(
            () {
              bloc.obtenerSolicitudesJugadorEquipo('1');
            },
          );
        }
      },
    );
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

  @override
  Widget build(BuildContext context) {
    bloc.obtenerSolicitudesJugadorEquipo(
        '1'); //Traemos los datos de las solicitudes
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 55,
        index: 4,
        buttonBackgroundColor: Colors.green,
        color: Colors.grey[50],
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.event,
            size: 20,
            color: _page == 0 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.table_chart,
            size: 20,
            color: _page == 1 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.people,
            size: 20,
            color: _page == 2 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.person_add,
            size: 20,
            color: _page == 3 ? Colors.white : Colors.green,
          ),
          Icon(
            Icons.portrait,
            size: 20,
            color: _page == 4 ? Colors.white : Colors.green,
          ),
        ],
        onTap: (index) {
          _presionaOpcion(index);
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: true,
              expandedHeight: 150.0,
              floating: true,
              primary: true,
              pinned: false,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 70, bottom: 30),
                
                title: Text(
                  _textHead,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: Colors.green,
            ),
          ];
        },
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
      ),
    );
  }

  Widget opcionVista() {
    switch (_page) {
      case 3:
        return StreamBuilder(
          stream: bloc.solicitudesJugadorEquipo,
          builder: (context, AsyncSnapshot<SolicitudJugadorModel> snapshot) {
            if (snapshot.hasData) {
              return jugadores.buildList(snapshot);
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
