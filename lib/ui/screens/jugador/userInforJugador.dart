import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba_bd/models/jugador.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/blocs/bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:prueba_bd/ui/Widgets/Inputs.dart';
import 'package:prueba_bd/ui/Widgets/buttonSolicitud.dart';
import 'dart:convert';

class UserInfoJugador extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoJugador>
    with AutomaticKeepAliveClientMixin {
  EstadoGlobal myProvider;
  final _formKey = GlobalKey<FormState>();
  Bloc bloc = new Bloc();
  int _opcion = 0;
  String contrasena;
  File _image;
  static TextEditingController controllerCedula =
      new TextEditingController(); // Maneja los datos ingresados por el input de Cedula
  static TextEditingController controllerNombre = new TextEditingController();
  static TextEditingController controllerCorreo = new TextEditingController();
  static TextEditingController controllerNombreEquipo =
      new TextEditingController();
  static TextEditingController controllerNumeroJugador =
      new TextEditingController();
  static TextEditingController controllerContrase = new TextEditingController();
  static TextEditingController controllerNewContrase =
      new TextEditingController();

  static TextEditingController controllerIDEquipo = new TextEditingController();
  final _inputsText = [
    {
      'buttonSubmit': 'Actualizar cédula', //texto que aparecerá en el botón
      'password': [
        {
          'text': 'Contraseña actual', //Texto del input
          'controller':
              controllerContrase, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.text, //Tipo de texto ingresado
          'obscureText': true, //obscureText ... Para contraseñas
        },
      ],
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Cédula', //Texto del input
          'controller':
              controllerCedula, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.number, //Tipo de texto ingresado
          'obscureText': false, //obscureText ... Para contraseñas
        },
      ]
    },
    {
      'buttonSubmit': 'Actualizar nombre', //texto que aparecerá en el botón
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Nombre', //Texto del input
          'controller':
              controllerNombre, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.text, //Tipo de texto ingresado
          'obscureText': false, //obscureText ... Para contraseñas
        },
      ]
    },
    {
      'buttonSubmit': 'Actualizar correo', //texto que aparecerá en el botón
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Correo', //Texto del input
          'controller':
              controllerCorreo, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.text, //Tipo de texto ingresado
          'obscureText': false, //obscureText ... Para contraseñas
        },
      ]
    },
    {
      'buttonSubmit': 'Actualizar contraseña', //texto que aparecerá en el botón
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Nueva contraseña', //Texto del input
          'controller':
              controllerNewContrase, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.text, //Tipo de texto ingresado
          'obscureText': true, //obscureText ... Para contraseñas
        },
      ]
    },
    {
      'buttonSubmit': 'Actualizar número', //texto que aparecerá en el botón
      'inputsText': [
        //Lista de inputs que aparecerá en cada interfaz
        {
          'text': 'Nuevo número', //Texto del input
          'controller':
              controllerNumeroJugador, //controlador que maneja los datos ingresados
          'keyBoardType': TextInputType.number, //Tipo de texto ingresado
          'obscureText': false, //obscureText ... Para contraseñas
        },
      ]
    },
  ];

  @override
  bool get wantKeepAlive => true;

  void cambiaOpcion(int opcion) {
    setState(() {
      this._opcion = opcion;
    });
  }

  bool comprobarContrasena(BuildContext context) {
    //Se comprueba que la contraseña ingresada por el usuario sea la misma registrada
    if (this.contrasena != controllerContrase.text) {
      Alert(
              context: context,
              title: "Contraseña incorrecta",
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
              type: AlertType.error,
              desc: "")
          .show();
      return false;
    } else
      return true;
  }

  Future ejecutarActualizacion(BuildContext context) async {
    //Los casos están dados por el orden de los datos dados en _inputstext
    if (_formKey.currentState.validate()) {
      if (this.comprobarContrasena(context)) {
        switch (this._opcion) {
          case 1:
            var newCedula = controllerCedula.text;
            var ejecutado = await this.bloc.updateCedulaUsuario(
                this.myProvider.jugadorUser.cedula, newCedula);
            if (ejecutado) {
              this.mensajeExito(context,
                  "Los administradores de liga revisarán la solicitud de actualización de cédula hecha");
            } else {
              this.mensajeErrorServidor(context);
            }
            print(ejecutado);
            print(newCedula);
            break;
          case 2:
            var newNombre = controllerNombre.text;
            var ejecutado = await this.bloc.updateNombreUsuario(
                this.myProvider.jugadorUser.cedula, newNombre);
            if (ejecutado) {
              this.mensajeExito(context,
                  "Los administradores de liga revisarán la solicitud de actualización de nombre hecha");
            } else {
              this.mensajeErrorServidor(context);
            }
            print(newNombre);
            break;
          case 3:
            var newCorreo = controllerCorreo.text;
            var body = await this.bloc.updateCorreoUsuario(
                this.myProvider.jugadorUser.cedula, newCorreo);
            if (body == 'prepare() failed') {
              this.mensajeAlerta(context, AlertType.error, 'Uh-oh', 'Okay',
                  'Ya existe un usuario registrado con ese correo', Colors.red);
            } else if (body == true) {
              this.mensajeErrorServidor(context);
            } else {
              this.mensajeExito(
                  context, 'El correo se ha actualizado con éxito');
            }
            break;
          case 4:
            var newContrasena = controllerNewContrase.text;
            var body = await this.bloc.updateContrasenaUsuario(
                this.myProvider.jugadorUser.cedula, newContrasena);
            if (body) {
              this.mensajeExito(
                  context, 'La contraseña se ha actualizado con éxito');
              Jugador jugador = this.myProvider.jugadorUser;
              jugador.contrasena = newContrasena;
              this.myProvider.jugadorUser = jugador;
              this.contrasena = newContrasena;
            } else {
              this.mensajeErrorServidor(context);
            }
            print(newContrasena);
            print(this.myProvider.jugadorUser.contrasena);
            print(body);
            break;
          case 5:
            var newNumero = controllerNumeroJugador.text;
            var ejecutado = await this.bloc.updateNumeroJugador(
                context,
                this.myProvider.jugadorUser.cedula,
                newNumero,
                this.myProvider.equipo.idEquipo);
            if (ejecutado == true) {
              this.mensajeExito(
                  context, 'El número se ha actualizado con éxito');
            }
            break;
          default:
            break;
        }
      }
    }
  }

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
      var ejecutado = await this.bloc.updateImageUsuario(
          this.myProvider.jugadorUser.cedula, base64Image, fileName);
      Navigator.pop(context);
      if (ejecutado) {
        this.mensajeExito(context, 'Se ha actualizado la imagen');
        setState(() {
          this.myProvider.jugadorUser.foto = fileName;
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
  Widget build(BuildContext context) {
    this.myProvider = Provider.of<EstadoGlobal>(context, listen: true);
    return Column(
      children: <Widget>[
        Container(
          child: opcionInfor(),
        ),
      ],
    );
  }

  Widget opcionInfor() {
    this.contrasena = this.myProvider.jugadorUser.contrasena;
    if (_opcion == 0) {
      return principalInfo();
    } else {
      return SizedBox(
        height: 500,
        child: Form(
          //Formulario, con este podremos hacer validaciones en las casillas input
          key: _formKey,
          child: ListView(
            physics:
                const BouncingScrollPhysics(), //Hacemos que el listview no sea scrollable
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: () => cambiaOpcion(0),
                  child: Text(
                    'Volver',
                    style: TextStyle(
                        color: Colors.green,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              ...(_inputsText[_opcion - 1][
                          'inputsText'] //Los botones hacen que _opcion cambie, de manera que la lista sólo mostrará los datos dados dentro de la casilla respectiva al número (=_opcion - 1)
                      as List<Map<String, Object>>)
                  .map((input) {
                return Inputs(
                    input['text'],
                    input['controller'],
                    input['keyBoardType'],
                    input['obscureText']); //Inputs con parámetros
              }).toList(),
              ...(_inputsText[0]['password'] as List<Map<String, Object>>)
                  .map((input) {
                return Inputs(
                    input['text'],
                    input['controller'],
                    input['keyBoardType'],
                    input['obscureText']); //Inputs con parámetros
              }).toList(),
              buttonSolicitud(
                  () => ejecutarActualizacion(context), 'Actualizar'),
            ],
          ),
        ),
      );
    }
  }

  Widget principalInfo() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        FlatButton(
          onPressed: () => alertaImage(),
          child: CachedNetworkImage(
            imageUrl:
                'https://futbolmx1.000webhostapp.com/imagenes/'+this.myProvider.jugadorUser.foto,
            imageBuilder: (context, imageProvider) => Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        FlatButton(
          onPressed: () => cambiaOpcion(
              2), //Si se presiona sobre el botón de nombre, el sistema trasladrá al usuario a la sección de nombre (2)
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Text(
              myProvider.jugadorUser.nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () => cambiaOpcion(1),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cédula",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(myProvider.jugadorUser.cedula),
              ],
            ),
          ),
        ),
        FlatButton(
          onPressed: () => cambiaOpcion(3),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Correo",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(myProvider.jugadorUser.correo),
              ],
            ),
          ),
        ),
        FlatButton(
          onPressed: () => {},
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Equipo",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(myProvider.equipo.nombre),
              ],
            ),
          ),
        ),
        FlatButton(
          onPressed: () => cambiaOpcion(5),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Número",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(myProvider.jugadorUser.numero),
              ],
            ),
          ),
        ),
        FlatButton(
          onPressed: () => cambiaOpcion(4),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Contraseña",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cerrar sesión",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
