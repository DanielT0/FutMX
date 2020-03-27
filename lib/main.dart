import 'package:flutter/material.dart';
import './interfazRegistro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              padding: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: Image.asset(
                      'assets/jugador.jpg',
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 15),
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, -10),
                            blurRadius: 15,
                          ),
                        ]),
                  ),
                  Container(
                    width: 270,
                    height: 90,
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new interfazRegistro(),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 270,
                    height: 35,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new interfazRegistro(),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
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
