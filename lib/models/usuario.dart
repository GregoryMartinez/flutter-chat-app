// To parse this JSON data, do
//
//     final usuario = usuarioFromMap(jsonString);

import 'dart:convert';

class Usuario {
  Usuario({
    this.token,
    required this.id,
    required this.nombre,
    required this.email,
    required this.online,
  });

  String? token;
  int id;
  String nombre;
  String email;
  bool online;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
    token: json["token"],
    id: json["id"],
    nombre: json["nombre"],
    email: json["email"],
    online: (json["online"] == 1) ? true : false,
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "id": id,
    "nombre": nombre,
    "email": email,
    "online": (online == true) ? 1 : 0,
  };
}
