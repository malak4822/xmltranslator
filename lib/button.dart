import 'package:flutter/material.dart';

class ButtonClass extends StatefulWidget {
  ButtonClass({Key? key, required this.onpressed}) : super(key: key);
  VoidCallback onpressed;
  @override
  State<ButtonClass> createState() => _ButtonClassState();
}

class _ButtonClassState extends State<ButtonClass> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          primary: Colors.white,
        ),
        onPressed: widget.onpressed,
        child: const Icon(
          Icons.translate,
          size: 50,
          color: Color.fromARGB(255, 47, 47, 47),
        ));
  }
}
