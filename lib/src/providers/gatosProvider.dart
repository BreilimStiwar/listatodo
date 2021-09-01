import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listtodo/src/models/cat_model.dart';

class CatsProvider{

  final String _url = 'https://catfact.ninja/facts';

  Future<List<Data>> gatoActividad(String limit ) async {  

    int getLimit = int.parse(limit);

    final url = Uri.parse('$_url?limit=$getLimit&max_length=50.json');

    final resp =  await http.get(url);

    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['data']);

    return cast.cats;

  }

}