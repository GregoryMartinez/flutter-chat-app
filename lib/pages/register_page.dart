import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Nombre Clase
class RegisterPage extends StatelessWidget {
    // Iniciar Variables

    // Constructor
    const RegisterPage({Key? key}) : super(key: key);

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
                                Logo(titulo: "Registro"),
                                _Form(),
                                Labels(ruta: "login", titulo1: "¿Ya tienes cuenta?", titulo2: "¡Ingresa ahora!"),
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
    final nameController = TextEditingController();
    @override
    Widget build(BuildContext context) {
        final authService = Provider.of<AuthService>(context);

        return Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
                children: [
                    CustomInput(icon: Icons.perm_identity, placeholder: "Nombre", keyboardType: TextInputType.text, textController: nameController),
                    CustomInput(icon: Icons.mail_outline, placeholder: "Correo", keyboardType: TextInputType.emailAddress, textController: emailController),
                    CustomInput(icon: Icons.lock_outline, placeholder: "Contraseña", textController: passwordController, isPassword: true),
                    BotonAzul(onPressed: authService.autenticando ? null : () async{
                        final registroOk = await authService.register(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
                        if (registroOk){
                            Navigator.pushReplacementNamed(context, "usuarios");
                        } else{
                            mostrarAlerta(context, "Registro Incorrecto", "Datos Incorrectos");
                        }
                    }, text: "Crear cuenta")
                ],
            )
        );
    }
}