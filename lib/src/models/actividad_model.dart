// To parse this JSON data, do
//
//     final actividadModel = actividadModelFromJson(jsonString);

import 'dart:convert';

ActividadModel actividadModelFromJson(String str) => ActividadModel.fromJson(json.decode(str));

String actividadModelToJson(ActividadModel data) => json.encode(data.toJson());

class ActividadModel {

    String ? id;
    String ? title;
    String ? description;
    bool   ? status;

    ActividadModel({
        this.id,
        this.title = '',
        this.description = '',
        this.status = true,
    });

    factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
        id          : json["id"],
        title       : json["title"],
        description : json["description"],
        status      : json["status"],
    );

    Map<String, dynamic> toJson() => {
        //"id"          : id,
        "title"       : title,
        "description" : description,
        "status"      : status,
    };
}
