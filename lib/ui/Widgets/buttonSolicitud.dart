import 'package:flutter/material.dart';

class buttonSolicitud extends StatelessWidget {
  final Function enviarSolicitud;

  buttonSolicitud(this.enviarSolicitud);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: 45,
        child: RaisedButton(
          onPressed: this.enviarSolicitud,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Enviar solicitud',
          ),
          textColor: Colors.white,
          color: Colors.green,
        ),
      ),
    );
  }
}
