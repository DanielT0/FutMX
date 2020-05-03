import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Payments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: WebviewScaffold(
        url:
            "https://futbolmx1.000webhostapp.com/pagos/pagar.php",
      ),
    );
  }
}
