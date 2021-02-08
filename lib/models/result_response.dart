// To parse this JSON data, do
//
//     final resultResponse = resultResponseFromJson(jsonString);

import 'dart:convert';

ResultResponse resultResponseFromJson(String str) => ResultResponse.fromJson(json.decode(str));

String resultResponseToJson(ResultResponse data) => json.encode(data.toJson());

class ResultResponse {
    ResultResponse({
        this.datos,
        this.fechaCorte,
        this.conInformacion,
    });

    List<Dato> datos;
    String fechaCorte;
    bool conInformacion;

    factory ResultResponse.fromJson(Map<String, dynamic> json) => ResultResponse(
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
        fechaCorte: json["fechaCorte"],
        conInformacion: json["conInformacion"],
    );

    Map<String, dynamic> toJson() => {
        "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
        "fechaCorte": fechaCorte,
        "conInformacion": conInformacion,
    };
}

class Dato {
    Dato({
        this.strNomPartido,
        this.strNomLista,
        this.strNomCandidato,
        this.intVotos,
        this.intVotosM,
        this.intVotosH,
        this.intOrdCandidato,
    });

    String strNomPartido;
    String strNomLista;
    String strNomCandidato;
    int intVotos;
    int intVotosM;
    int intVotosH;
    int intOrdCandidato;

    factory Dato.fromJson(Map<String, dynamic> json) => Dato(
        strNomPartido: json["strNomPartido"],
        strNomLista: json["strNomLista"],
        strNomCandidato: json["strNomCandidato"],
        intVotos: json["intVotos"],
        intVotosM: json["intVotosM"],
        intVotosH: json["intVotosH"],
        intOrdCandidato: json["intOrdCandidato"],
    );

    Map<String, dynamic> toJson() => {
        "strNomPartido": strNomPartido,
        "strNomLista": strNomLista,
        "strNomCandidato": strNomCandidato,
        "intVotos": intVotos,
        "intVotosM": intVotosM,
        "intVotosH": intVotosH,
        "intOrdCandidato": intOrdCandidato,
    };
}
