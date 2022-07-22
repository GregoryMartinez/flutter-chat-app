import 'dart:io';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Nombre Clase
class ChatPage extends StatefulWidget {
  // Iniciar Variables

  // Constructor
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

//State
class _ChatPageState extends State<ChatPage>  with TickerProviderStateMixin{
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    // Return
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text("Te", style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text("Melissa Flores", style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      return _messages[index];
                    })
            ),
            Divider(height: 1,),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: _inputChat(),
            )
          ],
        ),
      )
    );
  }

  Widget _inputChat(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Flexible(
                  child: TextField(
                    controller: _textController,
                    // onSubmitted: _handleSubmit,
                    onSubmitted: _handleSubmit,
                    onChanged: (String texto){
                      if(texto.trim().length > 0){
                        _estaEscribiendo = true;
                      } else{
                        _estaEscribiendo = false;
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: "Enviar mensaje",
                    ),
                    focusNode: _focusNode,
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child:
                Platform.isIOS
                ? CupertinoButton(
                    child: Text("Enviar"),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null
                )
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed:
                        _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  _handleSubmit(String texto){
    if (texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto,
      uid: "123",
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 350)),);

    _messages.insert(0,newMessage);
    newMessage.animationController.forward();

    _estaEscribiendo = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: off del socket
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}