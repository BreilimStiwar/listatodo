import 'package:flutter/material.dart';
import 'package:listtodo/src/models/cat_model.dart';
import 'package:listtodo/src/providers/gatosProvider.dart';

class Cats extends StatefulWidget {
  final String? limit;
  const Cats({Key? key, @required this.limit}) : super(key: key);

  @override
  _CatsState createState() => _CatsState();
}

class _CatsState extends State<Cats> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Comprobar')),
      body: _listCats(),
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
            itemBuilder: (BuildContext context, index) => _mostrarCats(context,cats[index])
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _mostrarCats(contex, Data cat ){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Card(
        elevation:2.0,
        child: Column(
          children: <Widget>[
            Text('${cat.fact}', style: TextStyle(fontSize: 16,color: Colors.blue)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${cat.length}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

}