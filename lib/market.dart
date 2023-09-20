import 'package:flutter/material.dart';

class Market extends StatelessWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        actions: const <Widget>[],
        backgroundColor: const Color.fromARGB(255, 221, 221, 221),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: const Center(
        child: Text(
          'This is the market.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
