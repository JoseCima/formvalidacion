import 'package:flutter/material.dart';
import 'package:formvalidacion/src/utils/utils.dart' as utils;


class ProductoPage extends StatefulWidget {

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.photo_size_select_actual)
          ),
           IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.camera_alt)
          ),
         ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){

      return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Producto',
          
        ),
        validator: (value){
           if(value!.length < 3){
             return 'Ingrese el nombre del producto';
           }else{
             return null;
           }
        }
      );
  }

  Widget _crearPrecio(){
   return TextFormField(
       keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'Precio',
        ),
        validator: (value){
           if(utils.isNumeric(value!)){
             return null;//pasa la validacion
           }else{
             return 'Sólo Números';
           }
        },
      );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.pink[300],
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

void _submit(){

  if(formKey.currentState!.validate()) return;

  print('Todo Okay');
}
}