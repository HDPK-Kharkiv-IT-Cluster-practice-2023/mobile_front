import 'package:flutter/material.dart';

class Market extends StatelessWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        titleTextStyle: null,
        actions: const <Widget>[],
        backgroundColor: null,
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
