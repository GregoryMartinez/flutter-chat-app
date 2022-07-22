import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/usuario.dart';

// Nombre Clase
class UsuariosPage extends StatefulWidget {
    // Iniciar Variables

    // Constructor
    const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}


// STATE
class _UsuariosPageState extends State<UsuariosPage> {

    RefreshController _refreshController = RefreshController(initialRefresh: false);

    final usuarios = [
      Usuario(uid: "1", nombre: "Maria", email: "maria@hotmail.com", online: true),
      Usuario(uid: "2", nombre: "Jose", email: "Jose@hotmail.com", online: false),
      Usuario(uid: "3", nombre: "Carlos", email: "carlos@hotmail.com", online: true)
    ];

    @override
    Widget build(BuildContext context) {

        // Return
        return Scaffold(
            appBar: AppBar(
                title: Text("Mi nombre", style: TextStyle(color: Colors.black54),),
                elevation: 1,
                backgroundColor: Colors.white,
                leading: Icon(Icons.exit_to_app, color: Colors.black54,),
                actions: [
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.check_circle, color: Colors.blue[400],),
                    )
                ],
            ),
            // CUERPO
            body: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: _cargarUsuarios,
              header: WaterDropHeader(
                complete: Icon(Icons.check, color: Colors.blue[400],),
                waterDropColor: Colors.blue,
              ),
              child: _ListViewUsuarios(usuarios: usuarios),
            )
        );
    }
    // Metodo cargar usuarios
    _cargarUsuarios() async{
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.refreshCompleted();
    }
}

// ListViewUsuarios
class _ListViewUsuarios extends StatelessWidget {
  const _ListViewUsuarios({
    Key? key,
    required this.usuarios,
  }) : super(key: key);

  final List<Usuario> usuarios;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
        itemCount: usuarios.length,
        separatorBuilder: (_, index) => Divider(),
        itemBuilder: (_, index){
          return _UsuarioListTile(usuarios: usuarios[index]);
        },
        );
  }
}

// List Tile de usuarios
class _UsuarioListTile extends StatelessWidget {
  const _UsuarioListTile({
    Key? key,
    required this.usuarios,
  }) : super(key: key);

  final Usuario usuarios;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuarios.nombre),
      subtitle: Text(usuarios.email),
      leading: CircleAvatar(
        child: Text(usuarios.nombre.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuarios.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100)
        ),
      ),
    );
  }
}