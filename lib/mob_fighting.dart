import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';
import 'package:http/http.dart' as http;
import 'fetch_mob.dart';

class FightingMobs extends StatefulWidget {
  const FightingMobs({Key? key}) : super(key: key);

  @override
  _FightingMobsState createState() => _FightingMobsState();
}

class _FightingMobsState extends State<FightingMobs> {
  @override
  void initState() {
    super.initState();
  }

  Character? character1;

  List<String> characterArray = [
    'assets/character0.png',
    'assets/character1.png',
    'assets/character2.png',
    'assets/character3.png',
    'assets/character4.png',
    'assets/character5.png'
  ];

  int mapToRange1To5(int id) {
    // Use modulo to wrap the input within the range [1, 5]
    double mappedValue = (id - 1) % 5 + 1;
    return mappedValue.toInt();
  }

  @override
  Widget build(BuildContext context) {
    var character1Hp = character1 != null ? character1!.health : 0;
    var mobHp = mob != null ? mob!.health : 0;

    var buttonIsDisabled = false;

    if (character1 != null && character1!.health <= 0) {
      buttonIsDisabled = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PvE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // Character1 avatar, Name, Healthbar padding.
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Stack(children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                      child: CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 13.0,
                        animation: false,
                        percent: character1Hp >= 0 ? character1Hp / 100 : 0,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Color.fromARGB(255, 144, 218, 146),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 151, 144),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(characterArray[
                                mapToRange1To5(character1?.id ?? 0)]),
                            radius: 30,
                          ),
                          Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    character1 != null
                                        ? character1!.name
                                        : 'N/A',
                                    style: TextStyle(fontSize: 26),
                                  ),
                                  LinearPercentIndicator(
                                    width: 100.0,
                                    lineHeight: 8.0,
                                    percent: 0.6,
                                    leading: new Text(
                                        "Lvl ${character1?.level ?? 0}"),
                                    trailing: new Text(
                                        "Lvl ${(character1?.level ?? 0) + 1}"),
                                    progressColor: Colors.orange,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ]),
                ),
                Text(
                  'Level: ${character1 != null ? character1!.level : 'N/A'}, XP: ${character1 != null ? character1!.xp : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${character1 != null ? character1!.health : 'N/A'}, Armor: ${character1 != null ? character1!.armor : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${character1 != null ? character1!.attack : 'N/A'}, Crit: ${character1 != null ? character1!.criticalAttack : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${character1 != null ? character1!.luck : 'N/A'}, Balance: ${character1 != null ? character1!.balance : 'N/A'} \$',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  // Mob avatar, Name, Healthbar padding.
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                        child: Stack(children: [
                          CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 13.0,
                            animation: false,
                            percent: mobHp >= 0 ? mobHp / 100 : 0,
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
                                      AssetImage("assets/skeleton.png"),
                                  radius: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    mob != null ? mob!.mob_name : 'N/A',
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
                  'Level: ${mob != null ? mob!.level : 'N/A'}, XP: ${mob != null ? mob!.xp : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${mob != null ? mob!.health : 'N/A'}, Armor: ${mob != null ? mob!.armor : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${mob != null ? mob!.attack : 'N/A'}, Crit: ${mob != null ? mob!.criticalAttack : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${mob != null ? mob!.luck : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            child: FilledButton(
              onPressed: () {
                if (!buttonIsDisabled) {
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('You lose…'),
                        content: const Text('The game is now over'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'New Game');
                            },
                            child: const Text('New Game'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: buttonIsDisabled
                    ? const Color.fromARGB(255, 158, 158, 158)
                    : Color.fromARGB(255, 191, 254, 207),
              ),
              child: Text(
                buttonIsDisabled ? 'Game over' : 'Fight Mob!',
                style: TextStyle(
                  fontSize: 18,
                  color: buttonIsDisabled
                      ? const Color.fromARGB(255, 255, 17, 0)
                      : const Color.fromARGB(255, 55, 133, 58),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
