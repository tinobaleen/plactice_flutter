import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/states/notifer.dart';
import 'src/widgets/chatlist.dart' as chat;

void main() {

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
   
         return MaterialApp(
         title:'Namer App',
         theme: ThemeData(
           useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MyHomePage(),
    );
  }
}



// class MyAppState extends ChangeNotifier {
//   var current = "sakusaku";
//   int count = 1;

//   void getNext() {
//     current = 'taisaku';
//     notifyListeners();
//   }
  
//   void upCount(){
//     count +=1;
//     notifyListeners();
//   }
// }



class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(allStateProvider);
    final appStateNotifier = ref.read(allStateProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: Text('Local LLM (gpt-oss:20b)'),
      ),
      body: Center(
        child: Column(// 基軸とななる列、
        children: [
            IconButton(onPressed: () {
              appStateNotifier.allDelete();
            }, icon: Icon(Icons.delete_forever_outlined)),
            Expanded(child: const chat.ChatList(key: ValueKey("chat_list_key"))),
          ],
        ),
      ),
    );
  }
}

class Counter extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(allStateProvider);
    final appStateNotifier = ref.read(allStateProvider.notifier);

    void incriment() {
      appStateNotifier.nextCount();
    }

    return Row(children: [
      Text( 'user name: ${appState.count}'),
      ElevatedButton(onPressed: incriment, child: Text('incriment'))
    ],);

  }
}