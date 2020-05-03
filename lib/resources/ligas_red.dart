import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_bd/models/liga.dart';

class ProveedorLigas {
  //Get All Todo items
  //Searches if query string was passed
  Future<LigaModel> obtenerListaLigas() async {

    http.Response response = await http.get('https://futbolmx1.000webhostapp.com/app/getAllLigas.php');
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var liga=LigaModel.fromJson(json.decode(response.body));
      
      return liga;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
