import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'main.dart';
import 'select_hero.dart';
import 'select_enemy.dart';
import 'gamemode_select.dart';
import 'fetch_mob.dart';

Character? hero;
Mob? enemy;

class FightingAction extends StatefulWidget {
  const FightingAction({super.key});

  @override
  _FightingActionState createState() => _FightingActionState();
}

class _FightingActionState extends State<FightingAction> {
  @override
  void initState() {
    super.initState();

    // Fetch the initial character data and set it to hero and enemy
    loadFight(selectedCharacterID,
        selectedEnemyID); // You should have a method to fetch the initial data.
  }

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

  void loadFight(int heroId, int enemyId) async {
    final apiUrl = Uri.parse(
        'http://$currentServer/api/v1/fight/$heroId/$enemyId?enemy_type=character');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        hero = Character.fromJson(data['hero']);
        enemy = Mob.fromJson(data['enemy']);
      });

      print('Load initiated successfully');
    } else {
      // Handle any errors
      print('Failed to load fight. Status code: ${response.statusCode}');
    }
  }

  void initiateFight(int heroId, int enemyId, String action) async {
    final apiUrl = Uri.parse(
        'http://$currentServer/api/v1/fight/$heroId/$enemyId?action=$action&enemy_type=character');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        hero = Character.fromJson(data['hero']);
        enemy = Mob.fromJson(data['enemy']);
      });

      if (data['message'] == "You successfully escaped") {
        // Navigate to CharacterSelect() screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CharacterSelect()),
        );
      } else {
        if (action == 'escape') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Could not escape...'),
            ),
          );
        }
      }
    } else {
      // Handle any errors
      print('Failed to initiate fight. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var heroHp = hero != null ? hero!.health : 0;
    var enemyHp = enemy != null ? enemy!.health : 0;

    var winner = "";
    var buttonIsDisabled = false;

    if (hero != null && hero!.health <= 0) {
      winner = enemy != null ? enemy!.mobName : 'N/A';
      buttonIsDisabled = true;
    }

    if (enemy != null && enemy!.health <= 0) {
      winner = hero != null ? hero!.name : 'N/A';
      buttonIsDisabled = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PvP'),
        titleTextStyle: null,
        actions: const <Widget>[],
        backgroundColor: null,
        bottomOpacity: 0.0,
        elevation: 0.0,
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
                  // Hero avatar, Name, Healthbar padding.
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Stack(children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                      child: CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 13.0,
                        animation: false,
                        percent: heroHp >= 0
                            ? heroHp > 100
                                ? 1 // If character.health is greater than 100, set percent to 1 (equivalent to 100%)
                                : heroHp / 100
                            : 0,
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
                            backgroundImage: AssetImage(
                                characterArray[mapToRange1To5(hero?.id ?? 0)]),
                            radius: 30,
                          ),
                          Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hero != null ? hero!.name : 'N/A',
                                    style: TextStyle(fontSize: 26),
                                  ),
                                  LinearPercentIndicator(
                                    width: 100.0,
                                    lineHeight: 8.0,
                                    percent: 0.6,
                                    leading: Text("Lvl ${hero?.level ?? 0}"),
                                    trailing:
                                        Text("Lvl ${(hero?.level ?? 0) + 1}"),
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
                  'Level: ${hero != null ? hero!.level : 'N/A'}, XP: ${hero != null ? hero!.xp : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${hero != null ? hero!.health : 'N/A'}, Armor: ${hero != null ? hero!.armor : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${hero != null ? hero!.attack : 'N/A'}, Crit: ${hero != null ? hero!.criticalAttack : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${hero != null ? hero!.luck : 'N/A'}, Balance: ${hero != null ? hero!.balance : 'N/A'} \$',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  // Enemy avatar, Name, Healthbar padding.
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
                            percent: enemyHp >= 0
                                ? enemyHp > 100
                                    ? 1 // If character.health is greater than 100, set percent to 1 (equivalent to 100%)
                                    : enemyHp / 100
                                : 0,
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
                                  backgroundImage: AssetImage(characterArray[
                                      mapToRange1To5(enemy?.id ?? 0)]),
                                  radius: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    enemy != null ? enemy!.mobName : 'N/A',
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
                  'Level: ${enemy != null ? enemy!.level : 'N/A'}, XP: ${enemy != null ? enemy!.xp : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${enemy != null ? enemy!.health : 'N/A'}, Armor: ${enemy != null ? enemy!.armor : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${enemy != null ? enemy!.attack : 'N/A'}, Crit: ${enemy != null ? enemy!.criticalAttack : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${enemy != null ? enemy!.luck : 'N/A'}, Balance: ${enemy != null ? enemy!.balance : 'N/A'} \$',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
              child: Row(
            children: [
              Spacer(),
              Spacer(),
              FilledButton(
                onPressed: () {
                  if (!buttonIsDisabled) {
                    setState(() {
                      initiateFight(
                          selectedCharacterID, selectedEnemyID, 'attack');
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('$winner wins'),
                          content: const Text('The game is now over'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CharacterSelect(),
                                    ));
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
                      : const Color.fromARGB(255, 253, 231, 255),
                ),
                child: Text(
                  buttonIsDisabled ? 'Game over' : 'Fight!',
                  style: TextStyle(
                    fontSize: 18,
                    color: buttonIsDisabled
                        ? const Color.fromARGB(255, 255, 17, 0)
                        : Colors.purple,
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (!buttonIsDisabled) {
                    initiateFight(
                        selectedCharacterID, selectedEnemyID, 'escape');
                  } else {}
                },
                child: Icon(
                  Icons.run_circle,
                  color: const Color.fromARGB(255, 253, 231, 255),
                ),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: !buttonIsDisabled
                        ? Colors.red
                        : const Color.fromARGB(255, 158, 158, 158)),
              ),
              Spacer()
            ],
          )),
        ],
      ),
    );
  }
}
