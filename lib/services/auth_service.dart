import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class AuthService with ChangeNotifier{
  late Usuario usuario;
  bool _autenticando = false;
  bool get autenticando => this._autenticando;

  final _storage = new FlutterSecureStorage();

  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token!;
  }

  static Future deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
  }
  
  Future<bool> login(String, email, String password) async{
    autenticando = true;

    final data = {"email": email, "password": password};

    final url = Uri.parse("${Environment.apiUrl}/login", );
    final resp = await http.post(url,
                          body: jsonEncode(data),
                          headers: {"Content-Type": "application/json"});
    if(resp.statusCode == 200){
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.usuario = loginResponse.usuario;
      this.autenticando = false;
      await this._guardarToken(this.usuario.token!);
      return true;
    }

    this.autenticando = false;
    return false;


  } // Future

  // Register
  Future<bool> register(String nombre, String email, String password) async{

    autenticando = true;

    final data = {"nombre": nombre, "email": email, "password": password};

    final url = Uri.parse("${Environment.apiUrl}/login/new", );
    final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"});

    if(resp.statusCode == 200){
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.usuario = loginResponse.usuario;
      this.autenticando = false;
      await this._guardarToken(this.usuario.token!);
      return true;
    }

    this.autenticando = false;
    return false;

  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: "token");
    final url = Uri.parse("${Environment.apiUrl}/login/renew");
    final resp = await http.get(url,
        headers: {"Content-Type": "application/json",
          "Authorization": (token == null) ? "" : token});
    if(resp.statusCode == 200){
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(this.usuario.token!);
      return true;
    }

    this._logout();
    return false;
  }

  Future _guardarToken(String token) async{
    return await _storage.write(key: "token", value: token);
  }

  Future _logout() async{
    await _storage.delete(key: "token");
  }
  
}