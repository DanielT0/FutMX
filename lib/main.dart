import 'package:flutter/material.dart';
import 'package:prueba_bd/interfazInicioSesion.dart';
import './interfazRegistro.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:prueba_bd/interfazRegistro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fut MX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Fut MX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                            child: Image.asset(
                              img,
                              fit: BoxFit.cover,
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

/**
  Future getData() async{
    var url = 'https://futmxpr.000webhostapp.com/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  Future makePostRequest() async {
  // set up POST request arguments
  String url = 'https://futmxpr.000webhostapp.com/insertSolicitudAdminEquipo.php';
  String json = '{"Cedula": 1 , "Nombre": "Daniel Torres", "NombreEquipo": "Los mejores", "Contraseña": "1234"}';
  // make POST request
  http.Response response = await http.post(url, body:{
    "Cedula":"2",
    "Nombre": "Manuel Castro",
    "NombreEquipo" : "Los mejores2",
    "Contraseña" : "123"
  });
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String body = response.body;
  print(statusCode);
  print(body);
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
  }


  @override
  void initState() {
    makePostRequest();
    getData();
  }
  **/
}
