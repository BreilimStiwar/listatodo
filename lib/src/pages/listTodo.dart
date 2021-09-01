import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:listtodo/src/models/actividad_model.dart';
import 'package:listtodo/src/providers/actividadesProvider.dart';



class ListToDo extends StatelessWidget {
  
  ListToDo({ Key? key }) : super(key: key); 

  final actividadesProvider = new ActividadesProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('List To-Do')),
      body: _crearListado(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Añadir',
        child: Icon(Icons.add),
        onPressed: () => agregarActividad(context),
      ),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: actividadesProvider.cargarActividades(),
      builder: (BuildContext context, AsyncSnapshot<List<ActividadModel>> snapshot) {
        if(snapshot.hasData){
          final actividades = snapshot.data;
          return ListView.builder(
            itemCount: actividades!.length,
            itemBuilder: (BuildContext context, index) => _crearItem(context,actividades[index])
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ActividadModel actividad){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) => actividadesProvider.borrarActividad(actividad.id.toString()),
      child: ListTile(
        title: Text('${actividad.title} - ${actividad.description}'),
        subtitle: Text(actividad.id.toString()),
        onTap: () => Navigator.pushNamed(context, 'agregar', arguments: actividad),
      ),
    );
  }
  
  agregarActividad(BuildContext context ) => Navigator.pushNamed(context, 'agregar');
  
  Future getData() async {
    final url = Uri.parse('https://catfact.ninja/breeds?limit=1');
    final response = await http.get(url, headers: {'Accept':'applicarion/json'});
    if(response.statusCode==200){
      final data = json.decode(response.body);
      print(data);
    }
  }

}