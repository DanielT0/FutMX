import 'package:flutter/material.dart';
import './interfazInicioSesion.dart';
import './interfazRegistro.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _current = 0;
  List imgList = [
    'assets/jugador.jpg',
    'assets/ball.jpg',
    'assets/play.jpg',
  ];

  List<T> mapFunction<T>(List list, Function handler) {
    //Funcion que recibe lista y otra función (basada en elementos) para ser ejecutada periodicamente con ellos (los circulitos)
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 110, 0, 0),
                child: Text(
                  'Fut MX',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                    height: 320,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        this._current = index;
                      });
                    },
                    items: imgList.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return (Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              child: Image.asset(
                                img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ));
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: mapFunction<Widget>(imgList, (index, img) {
                      return Container(
                        height: 10,
                        width: 10,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.grey[500]
                              : Colors.grey[200],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 270,
                    height: 45,
                    child: RaisedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new interfazInicioSesion(),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Iniciar sesión',
                      ),
                      textColor: Colors.white,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new interfazRegistro(),
                      ),
                    ),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    textColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}