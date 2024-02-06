import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final size;
  const MyBarrier({super.key, this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 8, color: const Color.fromARGB(255, 4, 93, 7))
      ),
    );
  }
}
