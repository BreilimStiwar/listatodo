import 'package:flutter/material.dart';
import 'package:listtodo/src/models/actividad_model.dart';
import 'package:listtodo/src/providers/actividadesProvider.dart';

class AgregarActividad  extends StatefulWidget {
  const AgregarActividad ({Key? key}) : super(key: key);

  @override
  _AgregarActividadState createState() => _AgregarActividadState();
}

class _AgregarActividadState extends State<AgregarActividad> {
  
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final actividadProvider = new ActividadesProvider();

  ActividadModel actividadModel = new ActividadModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    final ActividadModel? actividadData = ModalRoute.of(context)!.settings.arguments as ActividadModel?;
    
    if(actividadData!=null){
      actividadModel = actividadData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Agregar actividad')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _title(),
                _descripcion(),
                _status(),
                _buttonSave()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _title(){
    return TextFormField(
      initialValue: actividadModel.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Titulo'
      ),
      onSaved: (value) => actividadModel.title = value,
      validator: (value){
        if(value!.length == 0){
          return 'Ingrese el titulo de la actividad';
        }else{
          return null;
        }
      },
    );
  }

  Widget _descripcion(){
    return TextFormField(
      initialValue: actividadModel.description,
      decoration: InputDecoration(
        labelText: 'Descripción'
      ),
      onSaved: (value) => actividadModel.description = value,
      validator: (value){
        if(value!.length == 0){
          return 'Ingrese la descripcion de la actividad';
        }else{
          return null;
        }
      },
    );
  }

  Widget _status(){
    return SwitchListTile(
      value: actividadModel.status!,
      title: Text('Completado'), 
      onChanged: (value) => setState((){ actividadModel.status = value; })
    );
  }

  Widget _buttonSave(){
    return ElevatedButton.icon(
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit, 
    );
  }

  void _submit(){
    
    if(!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    
    setState(() => _guardando=true);

    if(actividadModel.id == null){
      actividadProvider.crearActividad(actividadModel);
      snackBar('Registro realizado');
    }else{
      actividadProvider.editarActividad(actividadModel);
      snackBar('Actualización realizada');
    }

    setState(() =>  _guardando=false);
    Navigator.pushNamed(context, 'inicio'); 
    
  }

  void snackBar(String mensaje){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.orange,
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

}