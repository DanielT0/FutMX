import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inputs extends StatelessWidget {
  final TextEditingController controllerConcontrase;
  final String texto;
  final bool obscureText;
  final TextInputType keyboard;

  Inputs( this.texto, this.controllerConcontrase, this.keyboard, this.obscureText);
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
            child: TextField(
              keyboardType: this.keyboard,
              obscureText: this.obscureText,
              controller: this.controllerConcontrase,
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
