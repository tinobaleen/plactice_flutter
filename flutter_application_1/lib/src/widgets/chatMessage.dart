import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/src/gen/to_client/v1/to_client.pbserver.dart';
import 'package:after_layout/after_layout.dart';


class ChatMessage extends StatefulWidget {
  
  
  final Stream<ChatMessageResponse> stream;

  const ChatMessage({super.key,required this.stream});

  @override
  State<ChatMessage> createState() => _ChatMessage();



}

// チャットのメッセージを表現するコンポーネント
class _ChatMessage extends State<ChatMessage> {


  String content = "";


  @override 
  void initState() {
    super.initState();
    widget.stream.listen((msg) {
      setState(() {
        content += msg.content;
      });
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    
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