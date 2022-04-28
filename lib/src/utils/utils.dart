//Determinando si es un numero o no

bool isNumeric(String s){
  if(s.isEmpty) return false;

  final n = num.tryParse(s);//Saber si se puede o no parsear  a un numero

  return ( n == null ? false : true); 
}