

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:formvalidacion/src/models/producto_model.dart';

class ProductosProvider{

   final String _url = 'https://flutter-multiusos-default-rtdb.firebaseio.com';

   Future<bool> crearProducto(ScanModel producto) async{
       final url = '$_url/productos.json';

       final resp = await http.post(Uri.parse(url), body: scanModelToJson(producto));

       final decodedData = json.decode(resp.body);

       print('Imprimiendo Decoded Data');

       print(decodedData.toString());

       return true;
   }


   Future<List<ScanModel>> cargarProductos() async {
    final url = '$_url/productos.json';

    //Obteniendo productos
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ScanModel> productos= [];

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp= ScanModel.fromJson(prod);
      prodTemp.id=id;
     productos.add(prodTemp);
    });
    print(productos);
    return productos;
  }

  Future<int> borrarProducto(String id) async{
     final url = '$_url/productos/$id.json';
     final resp = await http.delete(Uri.parse(url));

     print (resp.body);


     return 1;//ya se hizo
  }

  Future<bool> editarProducto(ScanModel producto) async{
       final url = '$_url/productos/${producto.id}.json';

       final resp = await http.put(Uri.parse(url), body: scanModelToJson(producto));//put nos sirve para actualizar

       final decodedData = json.decode(resp.body);

       print('Imprimiendo Decoded Data');

       print(decodedData.toString());

       return true;
   }



}