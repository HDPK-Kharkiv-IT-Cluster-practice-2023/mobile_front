import 'package:flutter/material.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FightingAction(),
    );
  }
}

class FightingAction extends StatelessWidget {
  const FightingAction({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: key,
        title: const Text('Kick'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        actions: const <Widget>[],
        backgroundColor: Color.fromARGB(255, 221, 221, 221),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          key: key,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/character2.png"),
                radius: 30,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Shane Cervantes',
                  style: TextStyle(fontSize: 24),
                ),
              )
            ]),
            Text(
              'Level: 20, XP: 65',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Health: 80, Armor: 15',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Attack: 12, Crit: 24',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Luck: 6',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Balance: 100 \$',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
