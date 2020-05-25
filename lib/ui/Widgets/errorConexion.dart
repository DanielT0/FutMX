import 'package:flutter/material.dart';

class AlertaError extends StatelessWidget {
  final double warningSize;
  final Future function;
  final String texto;
  final double containerSize;

  AlertaError(this.texto, this.function, this.warningSize, this.containerSize);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.grey,
                  size: this.warningSize,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  this.texto,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: this.containerSize,
                  child: RaisedButton(
                    onPressed: () => this.function,
                    child: Text('Recargar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
