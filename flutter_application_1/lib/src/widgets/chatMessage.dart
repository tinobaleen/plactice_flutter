import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// チャットのメッセージを表現するコンポーネント
class ChatMessage extends StatelessWidget {
  
  static const Map<int,String> msgTypeTable = {
    0:"ユーザー",
    1:"システム",
    2:"AI"
  };

  final String content;
  final String chatId;
  final String msgType;

  const ChatMessage({required this.content,required this.chatId,required this.msgType,super.key});

  @override
  Widget build(BuildContext context){

    return Card(
      child: Column(
        children: [
          Text(msgType),
          Text(content),
        ],
      ),
    );
  }

  
}