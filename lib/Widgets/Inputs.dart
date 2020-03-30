import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inputs extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final bool obscureText;
  final TextInputType keyboard;

  Inputs( this.texto, this.controller, this.keyboard, this.obscureText);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          height: 45,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Material(
            child: TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'Por favor ingresa este dato';
                }
                if (keyboard == TextInputType.number) {
                if(value.contains(new RegExp(r'[A-Z]'))){
                  return 'No se permiten letras';
                }
                if(value.contains(new RegExp(r'[a-z]'))){
                  return 'No se permiten letras';
                }
                }
              },
              keyboardType: this.keyboard,
              obscureText: this.obscureText,
              controller: this.controller,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                hintText: this.texto,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                enabled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
