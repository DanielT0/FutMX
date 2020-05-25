import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/Response/ApiResponse.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:prueba_bd/ui/Widgets/errorConexion.dart';
import 'package:prueba_bd/ui/Widgets/principalAdmin/jugadoresList.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

class InterfazJugadoresEquipo extends StatefulWidget {
  final Bloc bloc;

  InterfazJugadoresEquipo(this.bloc);

  @override
  _InterfazJugadoresEquipoState createState() =>
      _InterfazJugadoresEquipoState();
}

class _InterfazJugadoresEquipoState extends State<InterfazJugadoresEquipo>
    with AutomaticKeepAliveClientMixin {
  File _image;
  EstadoGlobal myProvider;
  Bloc bloc = new Bloc();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  void mensajeAlerta(
    BuildContext context,
    AlertType type,
    String title,
    String textButton,
    String desc,
    Color color,
  ) {
    Alert(
            context: context,
            title: title,
            buttons: [
              DialogButton(
                color: color,
                child: Text(
                  textButton,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            type: type,
            desc: desc)
        .show();
  }

  void mensajeExito(BuildContext context, String desc) {
    this.mensajeAlerta(
        context, AlertType.success, 'Listo!', 'Okay', desc, Colors.green);
  }

  void mensajeErrorServidor(BuildContext context) {
    this.mensajeAlerta(
        context,
        AlertType.error,
        'Hubo un error de conexión',
        'Okay',
        'Revisa tu conexión a internet e inténtalo de nuevo',
        Colors.red);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    Navigator.pop(context);
    this.alertaImage();
  }

  void alertaImage() {
    Alert(
      context: context,
      title: 'Seleccionar imagen',
      content: Column(
        children: <Widget>[
          _image == null ? Text('No image selected.') : Image.file(_image),
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.green,
          child: Text(
            'Actualizar imagen',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          onPressed: () => uploadImage(),
          width: 60,
        ),
        DialogButton(
          color: Colors.white,
          child: Text(
            'Escoger imagen',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onPressed: () => getImage(),
          width: 60,
        ),
      ],
    ).show();
  }

  Future uploadImage() async {
    if (_image != null) {
      String base64Image = base64Encode(_image.readAsBytesSync());
      String fileName = _image.path.split("/").last;
      var ejecutado = await this.bloc.updateImageEquipo(
          this.myProvider.administradorUser.equipo, base64Image, fileName);
      Navigator.pop(context);
      if (ejecutado) {
        this.mensajeExito(context, 'Se ha actualizado la imagen');
        setState(() {
          this.myProvider.equipo.foto = fileName;
        });
      } else {
        this.mensajeErrorServidor(context);
      }
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Debe seleccionar una imagen '),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var _proveedor = Provider.of<EstadoGlobal>(context, listen: false);
    this.myProvider = _proveedor;
    bloc.obtenerJugadoresEquipo(_proveedor.administradorUser.equipo, context);
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
                  FlatButton(
                    onPressed: alertaImage,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://futbolmx1.000webhostapp.com/imagenes/' +
                              _proveedor.equipo.foto,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.jugadoresEquipo,
              builder:
                  (context, AsyncSnapshot<ApiResponse<JugadorModel>> snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case Status.COMPLETED:
                      JugadoresList jugadores = new JugadoresList();
                      return jugadores.buildList(snapshot, context);
                      break;
                    case Status.ERROR:
                      return AlertaError(
                          snapshot.data.message,
                          bloc.obtenerPosiciones(
                              _proveedor.equipo.idLiga, context),
                          80,
                          30);
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
      ),
    );
  }
}
