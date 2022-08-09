import 'package:flutter/material.dart';

// Nombre Clase
class BotonAzul extends StatelessWidget {
    // Iniciar Variables
    final String text;
    final Function()? onPressed;
    // Constructor
    const BotonAzul({
      Key? key,
      required this.text,
      required this.onPressed,
    }) : super(key: key);

    // Override
    @override
    Widget build(BuildContext context) {
        return
          // Boton
          MaterialButton(
            onPressed: this.onPressed,
            disabledColor: Colors.grey,
            color: Colors.blue,
            shape: StadiumBorder(),
            elevation: 2,
            highlightElevation: 5,
            child: Container(
              width: double.infinity,
              height: 55,
              child: Center(
                child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17),),
              ),
            ),
          );
    }
}