import 'package:flutter/material.dart';

class checkBox extends StatelessWidget {
  final String title;
  final bool value;

  checkBox(this.title, this.value);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text(title),
            Checkbox(
                value: value,
                onChanged: (bool boolValue) {},
            )
        ],
    );
  }
}
