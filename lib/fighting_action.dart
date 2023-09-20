import 'package:flutter/material.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FightingAction(),
    );
  }
}

class FightingAction extends StatelessWidget {
  const FightingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: key,
        title: const Text('Kick'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        actions: const <Widget>[],
        backgroundColor: const Color.fromARGB(255, 221, 221, 221),
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          key: key,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
              child: Row(children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/character2.png"),
                  radius: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Shane Cervantes',
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ]),
            ),
            Text(
              'Level: 20, XP: 65',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Health: 80, Armor: 15',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Attack: 12, Crit: 24',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Luck: 6',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Balance: 100 \$',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 20),
              child: Row(children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/character1.png"),
                  radius: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Ashey Ho',
                    style: TextStyle(fontSize: 26),
                  ),
                )
              ]),
            ),
            Text(
              'Level: 16, XP: 45',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Health: 90, Armor: 10',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Attack: 16, Crit: 16',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Luck: 3',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Balance: 200 \$',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 253, 231, 255), // Background color
                ),
                child: const Text(
                  'Fight!',
                  style: TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
