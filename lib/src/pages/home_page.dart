import 'package:flutter/material.dart';
import 'package:formvalidacion/src/blocks/provider.dart';
import 'package:formvalidacion/src/models/producto_model.dart';
import 'package:formvalidacion/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {

   final productosProvider =  new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);
   

    return Scaffold(

      appBar: AppBar(
        title: Text('Home Page - José Cima'),
        
      ),
      body: _crearListado(),
      
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        if(snapshot.hasData){

          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos!.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i],
          ));
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    
  }

  Widget _crearItem(BuildContext context, ScanModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.pink[400],

      ),
      onDismissed: (direccion){
        // TODO: Borrar producto
        productosProvider.borrarProducto(producto.id.toString());
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id.toString()),
        onTap: () => Navigator.pushNamed(context, 'producto',  arguments: producto),
      ),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      backgroundColor: Colors.pink[300],
      onPressed: ()=>Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add));
  }

  
}