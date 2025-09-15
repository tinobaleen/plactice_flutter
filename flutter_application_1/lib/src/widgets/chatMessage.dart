import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/src/gen/to_client/v1/to_client.pbserver.dart';


class ChatMessage extends StatefulWidget {
  
  
  final Stream<ChatMessageResponse> stream;

  ChatMessage({super.key,required this.stream});

  @override
  State<ChatMessage> createState() => _ChatMessage();



}

// チャットのメッセージを表現するコンポーネント
class _ChatMessage extends State<ChatMessage> {


  String content = "";

  // static const Map<int,String> msgTypeTable = {
  //   0:"ユーザー",
  //   1:"システム",
  //   2:"AI"
  // };

  @override
  void initState() async {
    
    super.initState();
    await for( var msg in widget.stream) {
      appendMessage(msg.content);
    }

  }


  void appendMessage(String content) {
    setState(() {
      this.content = this.content + content;
    });
  }

  @override
  Widget build(BuildContext context){

    return Card(
      child: Column(
        children: [
          Text(content),
        ],
      ),
    );
  }

  
} 