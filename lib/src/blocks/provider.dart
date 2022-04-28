import 'package:flutter/material.dart';
import 'package:formvalidacion/src/blocks/login_block.dart';
export 'package:formvalidacion/src/blocks/login_block.dart';

class Provider extends InheritedWidget {

  //Arreglando el problema del provider
  //Debemos hacer que el provider necesita los argumentos de key y child.
  //Necesitamos crear un singleTone que la primera vez reciba información 
  //y la segunda vez simplemente la reutilice.


  static Provider? _instancia;

  factory Provider({Key? key, required Widget child}){//nos ayuda a saber si: 
  //es necesario regresar una nueva instancia de la clase o utilizar la ya existente.
    final instancia = _instancia ??= Provider._internal(key: key ,child:child);

    return instancia;//Sino, devolvemos la ya existente
  }

//Inicialización de la instancia
  Provider._internal({Key? key, required Widget child}) 
  : super(key: key, child: child);


  final loginBloc = LoginBlock();
//  
  

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  static LoginBlock of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc;
  }
}