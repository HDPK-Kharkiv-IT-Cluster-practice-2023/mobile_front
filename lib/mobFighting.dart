import 'package:flutter/material.dart';

class FightingMobs extends StatelessWidget {
  const FightingMobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mob Farm'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        actions: const <Widget>[],
        backgroundColor: const Color.fromARGB(255, 221, 221, 221),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: const Center(
        child: Text(
          'Fight mobs!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
