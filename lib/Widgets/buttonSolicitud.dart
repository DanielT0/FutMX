import 'package:flutter/material.dart';

class buttonSolicitud extends StatelessWidget {
  final Function enviarSolicitud;

  buttonSolicitud(this.enviarSolicitud);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: RaisedButton(
        onPressed: this.enviarSolicitud,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Enviar solicitud',
        ),
        textColor: Colors.white,
        color: Colors.green,
      ),
    );
  }
}
