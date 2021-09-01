import 'package:flutter/material.dart';
import 'package:listtodo/src/pages/agregar_actividad.dart';

import 'package:listtodo/src/pages/listTodo.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List ToDo',
      initialRoute: 'inicio',
      routes: {
        'inicio'  :  (BuildContext context) => ListToDo(),
        'agregar' : (BuildContext context)  => AgregarActividad(),
      },
    );
  }
}