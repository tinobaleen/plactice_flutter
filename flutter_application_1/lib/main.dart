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
        title: Text('Namer App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('A random'),
            Text(appState.current),
              Counter(),
              ElevatedButton(onPressed:(){
                appStateNotifier.nextCount();
            }, child: Text('Next')),
            const chat.ChatList(key: ValueKey("cahtList"),),
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

    void toLastName() {
      appStateNotifier.lastName();
    }

    
    return Row(children: [
      Text( 'Count: ${appState.count}'),
      ElevatedButton(onPressed: toLastName, child: Text('Increment'))
    ],);

  }
}