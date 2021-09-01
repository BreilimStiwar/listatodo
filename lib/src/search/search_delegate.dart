import 'package:flutter/material.dart';
import 'package:listtodo/src/models/actividad_model.dart';
import 'package:listtodo/src/providers/actividadesProvider.dart';

class ActividadesSearch extends SearchDelegate {

  final actividadesProvider = new ActividadesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        }, 
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.blue,
      ),
      onPressed: (){
        close(context, null);
      }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
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

  _crearItem(BuildContext context, ActividadModel actividad){
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
                Expanded(child: Text('${actividad.description}')),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.green)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete,  color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}