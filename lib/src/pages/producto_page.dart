import 'package:flutter/material.dart';
import 'package:formvalidacion/src/blocks/provider.dart';
import 'package:formvalidacion/src/models/producto_model.dart';
import 'package:formvalidacion/src/providers/productos_provider.dart';
import 'package:formvalidacion/src/utils/utils.dart' as utils;


class ProductoPage extends StatefulWidget {

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

    final formKey = GlobalKey<FormState>();
    final scaffoldkey = GlobalKey<ScaffoldState>();

    final productosProvider = new ProductosProvider();

    ScanModel producto = new ScanModel();
    bool _guardando = false;
    

  @override
  Widget build(BuildContext context) {

    final ScanModel prodData = ModalRoute.of(context)!.settings.arguments as ScanModel;

    if (prodData != null){
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldkey,
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
                _crearDisponible(),
                _crearBoton(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){

      return TextFormField(
        initialValue: producto.titulo,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Producto',
          
        ),
        onSaved: (value) => producto.titulo = value!,
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
     initialValue: producto.valor.toString(),
       keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'Precio',
        ),
        onSaved: (value) => producto.valor = double.parse(value!),
        validator: (value){
           if(utils.isNumeric(value!)){
             return null;//pasa la validacion
           }else{
             return 'Sólo Números';
           }
        },
      );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible, 
      title: Text('Disponible:'),
      activeColor: Colors.pink[300],
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
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
      onPressed: (_guardando) ? null :  _submit ,
    );
  }

void _submit(){

  if(!formKey.currentState!.validate()) return;

  formKey.currentState!.save();//Guardando los textFormFields
  

  setState(() { _guardando = true; });


  if(producto.id == null){
    productosProvider.crearProducto(producto);
    mostrarSnackbar('Registro guardado!', Colors.blue);
  }else{
    productosProvider.editarProducto(producto);
    mostrarSnackbar('Registro actualizado!', Colors.pink);

  }

  // setState(() { _guardando = false; });
  Navigator.pop(context);
}

void mostrarSnackbar(String mensaje, Color color){
  final snackbar = SnackBar(
    content: Text(mensaje),
    duration: Duration(milliseconds: 1500),
    backgroundColor: color,
    elevation: 5.0,
  );


  scaffoldkey.currentState!.showSnackBar(snackbar);
}
}