import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          key: key,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              // Character1 avatar, Name, Healthbar padding.
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 292, 0),
                    child: CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: 0.8,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color.fromARGB(255, 144, 218, 146),
                      backgroundColor: const Color.fromARGB(255, 255, 151, 144),
                    ),
                  ),
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
                ],
              ),
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
              // Mob avatar, Name, Healthbar padding.
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 292, 0),
                    child: CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: 0.25,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color.fromARGB(255, 144, 218, 146),
                      backgroundColor: const Color.fromARGB(255, 255, 151, 144),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Row(children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/skeleton.png"),
                        radius: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Skeleton',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Text(
              'Level: 16, XP: 45',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Health: 25, Armor: 10',
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
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsetsDirectional.fromSTEB(0, 65, 0, 0),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 191, 254, 207), // Background color
                ),
                child: const Text(
                  'Fight mob!',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 55, 133, 58)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
