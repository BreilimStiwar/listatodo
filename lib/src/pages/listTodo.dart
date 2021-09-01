import 'package:flutter/material.dart';

import 'package:listtodo/src/models/actividad_model.dart';
import 'package:listtodo/src/pages/cats_page.dart';
import 'package:listtodo/src/providers/actividadesProvider.dart';
import 'package:listtodo/src/providers/gatosProvider.dart';
import 'package:listtodo/src/search/search_delegate.dart';



class ListToDo extends StatefulWidget {
  
  ListToDo({ Key? key }) : super(key: key); 

  @override
  _ListToDoState createState() => _ListToDoState();
}

class _ListToDoState extends State<ListToDo> {
  final actividadesProvider = new ActividadesProvider();

  final gatosProvider = new CatsProvider();

  final numdata = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Actividades pendientes')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: ActividadesSearch(), 
                //query: 'Busca tus actividades'
              );
            },
          )
        ],
      ),
      body: _crearListado(),
    
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
                  _sendData(context)
                },
              )
            ],
          ),
        );
      }
    );
  }

  _sendData(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Cats(limit: numdata.text.toString())));
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
            Padding(
              padding: const EdgeInsets.only(top:8.0, bottom:8.0),
              child: Text('${actividad.title}', style: TextStyle(fontSize: 16,color: Colors.blue)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left:4.0),
                    child: Expanded(child: Text('${actividad.description}')),
                  ),
                ),
                
                IconButton(onPressed: () {Navigator.pushNamed(context, 'agregar', arguments: actividad);} , icon: Icon(Icons.edit, color: Colors.green)),
                IconButton(onPressed: () {actividadesProvider.borrarActividad(actividad.id.toString()); Navigator.pushNamed(context, 'inicio');  } , icon: Icon(Icons.delete,  color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  agregarActividad(BuildContext context ) => Navigator.pushNamed(context, 'agregar');
}