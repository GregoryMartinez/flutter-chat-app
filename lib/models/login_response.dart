// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';
import 'package:chat/models/usuario.dart';

class LoginResponse {
  LoginResponse({
    required this.error,
    required this.status,
    required this.usuario,
  });

  bool error;
  int status;
  Usuario usuario;

  factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
    error: json["error"],
    status: json["status"],
    usuario: Usuario.fromMap(json["body"]),
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "status": status,
    "usuario": usuario.toMap(),
  };
}
