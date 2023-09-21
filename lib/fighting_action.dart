import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'themes.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme, // Set the default theme to light.
      darkTheme: ThemeData.dark(), // Set the dark theme.
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
        titleTextStyle: null,
        actions: const <Widget>[],
        backgroundColor: null,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(
                key: key,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Stack(children: [
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: 0.65,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Color.fromARGB(255, 144, 218, 146),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 151, 144),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 7, 0, 0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/character2.png"),
                              radius: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                'Shane Cervantes',
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                      )
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
                    // Character2 avatar, Name, Healthbar padding.
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Stack(children: [
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: 0.65,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Color.fromARGB(255, 144, 218, 146),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 151, 144),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 7, 0, 0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/character1.png"),
                                    radius: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Ashley Ho',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                                ],
                              ),
                            )
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
                    'Health: 65, Armor: 10',
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
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 253, 231, 255), // Background color
                    ),
                    child: const Text(
                      'Fight!',
                      style: TextStyle(fontSize: 18, color: Colors.purple),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
