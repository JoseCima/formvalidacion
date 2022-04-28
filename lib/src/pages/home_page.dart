import 'package:flutter/material.dart';
import 'package:formvalidacion/src/blocks/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(

      appBar: AppBar(
        title: Text('Home Page - José Cima'),
        
      ),
      body: Container(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      backgroundColor: Colors.pink[300],
      onPressed: ()=>Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add));
  }
}