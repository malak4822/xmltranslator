import 'package:flutter/material.dart';

class ButtonClass extends StatefulWidget {
  ButtonClass({Key? key, required this.whenClick}) : super(key: key);
  VoidCallback whenClick;
  @override
  State<ButtonClass> createState() => _ButtonClassState();
}

class _ButtonClassState extends State<ButtonClass> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(30),
          primary: Colors.white,
        ),
        onPressed: widget.whenClick,
        child: const Icon(
          Icons.translate,
          size: 50,
          color: Color.fromARGB(255, 47, 47, 47),
        ));
  }
}
