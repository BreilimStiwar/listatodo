import 'package:flutter/material.dart';
import 'package:listtodo/src/models/actividad_model.dart';
import 'package:listtodo/src/models/cat_model.dart';
import 'package:listtodo/src/providers/actividadesProvider.dart';
import 'package:listtodo/src/providers/gatosProvider.dart';

class Cats extends StatefulWidget {
  final String? limit;
  const Cats({Key? key, @required this.limit}) : super(key: key);

  @override
  _CatsState createState() => _CatsState();
}

class _CatsState extends State<Cats> {


  final actividadProvider = new ActividadesProvider();
  List datos = [];

  ActividadModel actividadModel = new ActividadModel();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Comprobar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Se agragaran las siguientes actividades a la lista de actividades', style: TextStyle(fontSize:16, fontWeight: FontWeight.w500)),
          ),
          Expanded(child: _listCats()),
          _saved(),
        ],
      ),
      
    );
  }

  Widget _listCats(){

    final catProvider = new CatsProvider();

    return FutureBuilder(
      future: catProvider.gatoActividad(widget.limit!),
      builder: (BuildContext cotext, AsyncSnapshot<List<Data>>? snapshot){
        if(snapshot!.hasData){
          final cats = snapshot.data;
          return ListView.builder(
            itemCount: cats!.length,
            itemBuilder: (BuildContext context, index){
              // actividadModel.title = 'Tarea $index';
              // actividadModel.description = cats[index].fact;
              // actividadModel.status=false;
              //datos.addAll(cats);
              return _mostrarCats(context,cats[index]);
            });
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  //  actividadModel.title = 'Tarea $index';
  //             actividadModel.description = cats[index].fact;

  Widget _mostrarCats(contex, Data cat){
    datos.add(cat.fact);
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Card(
        elevation:2.0,
        child: Column(
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${cat.fact}', style: TextStyle(fontSize: 16,color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _saved(){
    return ElevatedButton.icon(
      label: Text('Aceptar'),
      icon: Icon(Icons.save),
      onPressed:  _submit, 
    );
  }

  void _submit(){
    
    datos.map((e) {
      actividadModel.title = 'Prueba';
      actividadModel.description = e;
      actividadModel.status=false;
      actividadProvider.crearActividad(actividadModel);
    }).toList();

    Navigator.pushNamed(context, 'inicio');

    //print(datos);
    //actividadProvider.crearActividad(actividadModel);
  }

}