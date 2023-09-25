import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';

class FightingMobs extends StatefulWidget {
  const FightingMobs({Key? key}) : super(key: key);

  @override
  _FightingMobsState createState() => _FightingMobsState();
}

class _FightingMobsState extends State<FightingMobs> {
  Map<String, dynamic> character1Data = {};
  Map<String, dynamic> character2Data = {};

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        character1Data = data['character1Data'];
        character2Data = data['character2Data'];
      });
    }).catchError((error) {
      // Обработка ошибки, если необходимо
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mob Farm'),
        actions: const <Widget>[],
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Stack(
                children: [
                  CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: 0.8,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Color.fromARGB(255, 144, 218, 146),
                    backgroundColor: const Color.fromARGB(255, 255, 151, 144),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/character2.png"),
                          radius: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            character1Data['name'] ?? 'N/A', // Используем данные
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Level: ${character1Data['level'] ?? 'N/A'}, XP: ${character1Data['xp'] ?? 0}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Health: ${character1Data['health'] ?? 'N/A'}, Armor: ${character1Data['armor'] ?? 0}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Attack: ${character1Data['attack'] ?? 'N/A'}, Crit: ${character1Data['critical_attack'] ?? 0}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Luck: ${character1Data['luck'] ?? 'N/A'}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Balance: \$${character1Data['balance'] ?? 'N/A'}',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: 0.25,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Color.fromARGB(255, 144, 218, 146),
                    backgroundColor: const Color.fromARGB(255, 255, 151, 144),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/skeleton.png"),
                          radius: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Skeleton',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Level: ${character2Data['level'] ?? 'N/A'}, XP: ${character2Data['xp'] ?? 0}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Health: ${character2Data['health'] ?? 'N/A'}, Armor: ${character2Data['armor'] ?? 0}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Attack: ${character2Data['attack'] ?? 'N/A'}, Crit: ${character2Data['critical_attack'] ?? 0}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Luck: ${character2Data['luck'] ?? 'N/A'}',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(top: 43),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 191, 254, 207),
                ),
                child: const Text(
                  'Fight mob!',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 55, 133, 58)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
