import 'package:chat/pages/pages.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Nombre Clase
class LoadingPage extends StatelessWidget {
    // Iniciar Variables

    // Constructor
    const LoadingPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {

        // Return
        return Scaffold(
            body: FutureBuilder(
                future: checkLoginState(context),
                builder: (context, snapshot){
                    return _Circular();
                },
            )
        );
    }

    Center _Circular() {
      return Center(
          child: CircularProgressIndicator(),
          );
    }

    Future checkLoginState(BuildContext context) async{
        final authService = Provider.of<AuthService>(context, listen: false);
        final autenticado = await authService.isLoggedIn();
        if (autenticado) {
          // TODO: CONECTAR AL SOCKET SERVER
          // Navigator.pushReplacementNamed(context, "usuarios");
          Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: (_, __, ___) =>UsuariosPage(),
              transitionDuration: Duration(milliseconds: 1500),
            )
          );
        } else{
          Navigator.pushReplacementNamed(context, "login");
        }

    }

}