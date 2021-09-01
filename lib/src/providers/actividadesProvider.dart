import 'dart:convert';

import 'package:listtodo/src/models/actividad_model.dart';
import 'package:http/http.dart' as http;

class ActividadesProvider{

  final String _url = 'https://actividades-95c4e-default-rtdb.firebaseio.com';

  Future<bool> crearActividad( ActividadModel actividadModel ) async { 
    
    final url = Uri.parse('$_url/actividades.json');

    final resp =  await http.post( url, body: actividadModelToJson(actividadModel) );

    final decodedData = json.decode(resp.body);

    print(decodedData);
    
    return true;
  
  }

  Future<bool> editarActividad( ActividadModel actividad ) async { 
    
    final url = Uri.parse('$_url/actividades/${ actividad.id }.json');

    final resp =  await http.put( url, body: actividadModelToJson(actividad) );

    final decodedData = json.decode(resp.body);

    print(decodedData);
    
    return true;
  
  }

  Future<List<ActividadModel>> cargarActividades() async {

    final url = Uri.parse('$_url/actividades.json');
    final resp = await http.get(url);

    final Map<String, dynamic>? decodedData = json.decode(resp.body);
    final List<ActividadModel>  actividades = []; 

    if(decodedData == null) return [];

    decodedData.forEach((id, actividad) { 

      final actvTemp = ActividadModel.fromJson(actividad);
      actvTemp.id = id;

      actividades.add(actvTemp);

    });

    return actividades;

  }

  Future<int> borrarActividad( String id) async {
    
    final url  = Uri.parse('$_url/actividades/$id.json');
    final resp = await http.delete(url); 
    print(json.decode(resp.body));

    return 1;

  }

}