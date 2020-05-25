import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:prueba_bd/ui/Widgets/alert.dart';
import 'package:prueba_bd/ui/screens/General/interfazPosiciones.dart';
import 'package:prueba_bd/ui/screens/interfazEventos.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/ui/screens/jugador/userInforJugador.dart';

import 'dart:async';

import 'package:rflutter_alert/rflutter_alert.dart';

class PrincipalJugador extends StatefulWidget {
  @override
  _principalJugadorState createState() => _principalJugadorState();
}

class _principalJugadorState extends State<PrincipalJugador> {
  int _page = 0;
  String _textHead = "Eventos";
  GlobalKey _bottomNavigationKey = GlobalKey();
  Bloc bloc = new Bloc();
  Alerta alerta = new Alerta();
  PageController _c;
  @override
  void initState() {
    this._page = 0;
    this._c = new PageController(
      initialPage: 0,
    );
    super.initState();
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
            _textHead = "Eventos";
            break;
        }
      },
    );
  }

  Future<bool> _mostrarAlertaSalida() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¿Seguro que quieres salir?'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Sí',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            color: Colors.white,
            child: Text(
              'No',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () => Navigator.pop(context, false),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _mostrarAlertaSalida,
      child: Scaffold(
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
            this._c.jumpToPage(index);
          },
        ),
        body: PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
              this._presionaOpcion(newPage);
              final CurvedNavigationBarState navBarState =
                  _bottomNavigationKey.currentState;
              navBarState.setPage(newPage);
            });
          },
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: InterfazEventosAdmin(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: InterfazPosiciones(bloc),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: UserInfoJugador(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
