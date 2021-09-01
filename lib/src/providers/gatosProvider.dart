import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listtodo/src/models/actividad_model.dart';

class GatosProvider{

  final String _url = 'https://catfact.ninja/facts';

  Future<bool> gatoActividad(String limit ) async {  

    int getLimit = int.parse(limit);

    final url = Uri.parse('$_url?limit=$getLimit&max_length=50.json');

    final resp =  await http.get(url);

    final decodedData = json.decode(resp.body);

    print(decodedData['data']);

    // print(limit);

    return true;

  }

}