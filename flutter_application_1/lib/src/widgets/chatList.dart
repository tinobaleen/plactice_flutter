import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:namer_app/src/gen/to_client/v1/to_client.pb.dart';
import '../tranceport/trancepot.dart' as tranceport;
import '../states/notifer.dart' as provider;
import '../widgets/chatMessage.dart';



//ChatListをConsumerStatefullWidgetに変換し、状態の（入力内容）を管理します
class ChatList extends ConsumerStatefulWidget {
  const ChatList({required super.key});

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}





class _ChatListState extends ConsumerState<ChatList> {
  //入力欄を管理するためのコントローラー
  final TextEditingController _textController = TextEditingController();

  Future<void> _sendMessgae(String message) async {
    //からメッセージを送信しない
    if (message.isEmpty) return;

    //メッセージ送信後にTextFieldをクリア
    _textController.clear();

    try {
      //サーバーへのストリーミング  
      final streaming = tranceport.chatClient.messageRequest( ChatMessageRequest(
        chatId: "",
        content: message
      ),
      );


      ref.read(provider.allStateProvider.notifier).insertMessageWidet(streaming);
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //　プロバイダの状態を監視
    final allState = ref.watch(provider.allStateProvider);
    //CahtMessageResponseのリストをChatMessageウィジェットのリストに変換
    final List<ChatMessage> msgArray = allState.chatMessage;


    return Column(
      children: [
        Expanded(
          child:ListView(
            children: msgArray,
          ) ,
        
        ),
        //入力と送信ボタン
        Padding(
          padding:const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "メッセージ入力",
                ),
                onSubmitted: (_) => _sendMessgae(_textController.text),
              )),
              IconButton(onPressed:()=> _sendMessgae(_textController.text), icon: Icon(Icons.send)),
            ],
          ), 
        ),
      ],
    );


  }
}