import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Alerta {
  void showAlert(BuildContext context, String titulo, String textButton,
      String desc, Color color, void func) {
    Alert(
            context: context,
            title: titulo,
            buttons: [
              DialogButton(
                color: color,
                child: Text(
                  textButton,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () => func,
                width: 120,
              )
            ],
            type: AlertType.error,
            desc: desc)
        .show();
  }
}
