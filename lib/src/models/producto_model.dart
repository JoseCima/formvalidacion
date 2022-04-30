// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
         this.id,
         this.titulo = '',
         this.valor = 0.0,
         this.disponible = true,
         this.fotoUrl,
    });

    String? id;
    String titulo;
    double valor;
    bool disponible;
    String? fotoUrl;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id         : json["id"],
        titulo     : json["titulo"],
        valor      : json["valor"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoURL"],
    );

    Map<String, dynamic> toJson() => {
       // "id"         : id,
        "titulo"     : titulo,
        "valor"      : valor,
        "disponible" : disponible,
        "fotoURL"    : fotoUrl,
    };
}
