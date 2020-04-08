import 'package:flutter/material.dart';

class snackBar extends StatelessWidget {
  final String texto; //Texto que se mostrará
  final Color color;

  snackBar(this.texto, this.color);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        this.texto,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: this.color,
    );
  }
}
