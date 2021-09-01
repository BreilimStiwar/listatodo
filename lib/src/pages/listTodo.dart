import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:listtodo/src/models/actividad_model.dart';
import 'package:listtodo/src/providers/actividadesProvider.dart';
import 'package:listtodo/src/providers/gatosProvider.dart';



class ListToDo extends StatelessWidget {
  
  ListToDo({ Key? key }) : super(key: key); 

  final actividadesProvider = new ActividadesProvider();
  final gatosProvider = new GatosProvider();
  final numdata = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Actividades pendientes'))),
      body: _crearListado(),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Añadir',
      //   child: Icon(Icons.add),
      //   onPressed: () => agregarActividad(context),
      // ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () => modalPeticion(context),
              child: Icon(Icons.cabin),
            ),
            SizedBox(height: 10.0),
            FloatingActionButton(
              onPressed: () => agregarActividad(context),
              child: Icon(Icons.add),
            )
          ]
        ),
      ),


      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(2.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       FloatingActionButton(
      //         onPressed: () {},
      //         child: Icon(Icons.navigate_before),
      //       ),
      //       FloatingActionButton(
      //         onPressed: () {},
      //         child: Icon(Icons.navigate_next),
      //       )
      //     ]
      //   )
      // ),
    );
  }

  modalPeticion(BuildContext context){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children:[
              Text('Petición', style: TextStyle(fontSize: 26.0)),
              Spacer(),
              IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.cancel, color: Colors.blue))
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              Divider(),
              TextFormField(
                controller: numdata,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número de gatos deseados'
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue,
                child: Text('Recibir', style: TextStyle(color: Colors.white),),
                onPressed: () => {
                  _obtenerData()
                },
              )
            ],
          ),
        );
      }
    );
  }

  _obtenerData(){
    gatosProvider.gatoActividad(numdata.text.toString());
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
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Card(
        elevation:2.0,
        child: Column(
          children: <Widget>[
            Text('${actividad.title}', style: TextStyle(fontSize: 16,color: Colors.blue)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${actividad.description}'),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.green)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete,  color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
    // return Dismissible(
    //   key: UniqueKey(),
    //   background: Container(
    //     color: Colors.red,
    //   ),
    //   onDismissed: (direction) => actividadesProvider.borrarActividad(actividad.id.toString()),
    //   child: ListTile(
    //     title: Text('${actividad.title} - ${actividad.description}'),
    //     subtitle: Text(actividad.id.toString()),
    //     onTap: () => Navigator.pushNamed(context, 'agregar', arguments: actividad),
    //   ),
    // );
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