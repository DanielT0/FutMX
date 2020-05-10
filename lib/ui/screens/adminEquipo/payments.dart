import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:prueba_bd/providers/estadoGlobal.dart';

class Payments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<EstadoGlobal>(context, listen: false);
    return Container(
      height: 300,
      child: WebviewScaffold(
        url:
            "https://futbolmx1.000webhostapp.com/pagos/pagar.php?Total="+myProvider.liga.precio+"&Partido="+myProvider.partido+"&Equipo="+myProvider.administradorUser.equipo,
      ),
    );
  }
}
