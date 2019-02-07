import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final List<Widget> divided;

  SecondScreen(this.divided);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Add 6 lines from here...
      appBar: new AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: new ListView(children: divided),
    );
  }
}
