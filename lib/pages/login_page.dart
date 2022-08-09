import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/pages/pages.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Nombre Clase
class LoginPage extends StatelessWidget {
    // Iniciar Variables

    // Constructor
    const LoginPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {

        // Return
        return Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.95,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Logo(titulo: "Messenger"),
                          _Form(),
                          Labels(ruta: "register", titulo1: "¿No tienes cuenta?", titulo2: "¡Crea una ahora!"),
                          Text("Términos y condiciones de uso", style: TextStyle(fontWeight: FontWeight.w200),)
                      ],
                  ),
                ),
              ),
            ),
        );
    }
}

// Formulario
class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
            children: [
                CustomInput(icon: Icons.mail_outline, placeholder: "Correo", keyboardType: TextInputType.emailAddress, textController: emailController),
                CustomInput(icon: Icons.lock_outline, placeholder: "Contraseña", textController: passwordController, isPassword: true),
                BotonAzul(onPressed: (authService.autenticando) ? null : () async{
                  FocusScope.of(context).unfocus();
                  final loginOk = await authService.login(String, emailController.text.trim(), passwordController.text.trim());
                  if(loginOk){
                    Navigator.pushReplacementNamed(context, "usuarios");
                  } else{
                    // Mostrar alerta
                    mostrarAlerta(context, "Login Incorrecto", "Revise sus credenciales");
                  }
                }, text: "Ingrese")
            ],
        )
    );
  }
}