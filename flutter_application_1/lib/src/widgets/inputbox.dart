


import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const InputBox ({
    super.key,
    required this.controller,
    required this.onSend,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:const EdgeInsets.symmetric(horizontal:8.0),
      child:Row(
        
        children:  [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText:'message inputs',
              border: InputBorder.none, 
            ),
          onSubmitted: (_) => onSend(),
          ),
         
        ),
         const SizedBox(width: 8.0),
          IconButton(icon: const Icon(Icons.send),
          onPressed: onSend,
          ),
      ], 
    ));
  }

  
}


// class InputBox extends StatelessWidget {
//   const TextField textfield = TextField();
//   const IconButton sendButton = IconButton(onPressed: onPressed, icon: icon);
//   const Sender (String)=> Void;


//   const InputBox({super.key});

//   void initState(){
//     this.textfield = TextField();
//     this.BackButton = IconButton(onPressed: onPressed, icon: icon)
//   }

//   void _on_changed(){

//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Row(
//       children: [
//         this.textfield,
//         this.sendButton,
//       ],
//     );
//   }

// }