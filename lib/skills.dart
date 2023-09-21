import 'package:flutter/material.dart';

class Skills extends StatelessWidget {
  const Skills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
        titleTextStyle: null,
        actions: const <Widget>[],
        backgroundColor: null,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: const Center(
        child: Text(
          "So it's not a skill issue anymore.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
