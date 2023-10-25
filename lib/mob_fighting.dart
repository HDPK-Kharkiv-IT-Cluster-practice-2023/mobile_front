// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:fightingapp/select_hero.dart';
import 'package:fightingapp/select_mob.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';
import 'package:http/http.dart' as http;
import 'fetch_mob.dart';
import 'main.dart';
import 'dart:convert';

class FightingMobs extends StatefulWidget {
  const FightingMobs({Key? key}) : super(key: key);

  @override
  _FightingMobsState createState() => _FightingMobsState();
}

class _FightingMobsState extends State<FightingMobs> {
  @override
  void initState() {
    super.initState();
    loadFight(selectedCharacterID, selectedMobID);
  }

  Character? hero;
  Mob? mob;

  void loadFight(int heroId, int enemyId) async {
    final apiUrl = Uri.parse(
        'http://$currentServer/api/v1/fight/$heroId/$enemyId?enemy_type=mob');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        hero = Character.fromJson(data['hero']);
        mob = Mob.fromJson(data['enemy']);
      });

      print('Load initiated successfully');
    } else {
      // Handle any errors
      print('Failed to load fight. Status code: ${response.statusCode}');
    }
  }

  void initiateFight(int heroId, int enemyId, String action) async {
    final apiUrl = Uri.parse(
        'http://$currentServer/api/v1/fight/$heroId/$enemyId?action=$action&enemy_type=mob');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        hero = Character.fromJson(data['hero']);
        mob = Mob.fromJson(data['enemy']);
      });

      if (data['message'] == "You successfully escaped") {
        // Navigate to CharacterSelect() screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CharacterSelect()),
        );
      } else {
        if (action == 'escape') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not escape...'),
            ),
          );
        }
      }
    } else {
      // Handle any errors
      print('Failed to initiate fight. Status code: ${response.statusCode}');
    }
  }

  List<String> characterArray = [
    'assets/character0.png',
    'assets/character1.png',
    'assets/character2.png',
    'assets/character3.png',
    'assets/character4.png',
    'assets/character5.png'
  ];

  List<String> mobArray = [
    'assets/goblin.png',
    'assets/skeleton.png',
    'assets/slime.png',
    'assets/spider.png',
    'assets/zombie.png',
  ];

  String mobAvatar(String name) {
    switch (name) {
      case 'Goblin':
        return mobArray[0];
      case 'Skeleton':
        return mobArray[1];
      case 'Slime':
        return mobArray[2];
      case 'Spider':
        return mobArray[3];
      case 'Zombie':
        return mobArray[4];
      default:
        return mobArray[4];
    }
  }

  int mapToRange1To5(int id) {
    // Use modulo to wrap the input within the range [1, 5]
    double mappedValue = (id - 1) % 5 + 1;
    return mappedValue.toInt();
  }

  @override
  Widget build(BuildContext context) {
    var heroHp = hero != null ? hero!.health : 0;
    var mobHp = mob != null ? mob!.health : 0;
    var winner = "";

    var buttonIsDisabled = false;

    if (hero != null && hero!.health <= 0) {
      buttonIsDisabled = true;
      winner = "You lose!";
    } else if (mob != null && mob!.health <= 0) {
      buttonIsDisabled = true;
      winner = "You win";
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
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                        child: CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 13.0,
                          animation: false,
                          percent: heroHp >= 0 ? heroHp / 100 : 0,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor:
                              const Color.fromARGB(255, 144, 218, 146),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 151, 144),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                characterArray[mapToRange1To5(hero?.id ?? 0)],
                              ),
                              radius: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hero != null ? hero!.name : 'N/A',
                                    style: const TextStyle(fontSize: 26),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Level: ${hero != null ? hero!.level : 'N/A'}, XP: ${hero != null ? hero!.xp : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${hero != null ? hero!.health : 'N/A'}, Armor: ${hero != null ? hero!.armor : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${hero != null ? hero!.attack : 'N/A'}, Crit: ${hero != null ? hero!.criticalAttack : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${hero != null ? hero!.luck : 'N/A'}, Balance: ${hero != null ? hero!.balance : 'N/A'} \$',
                  style: const TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                        child: Stack(
                          children: [
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 13.0,
                              animation: false,
                              percent: mobHp >= 0 ? mobHp / 100 : 0,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor:
                                  const Color.fromARGB(255, 144, 218, 146),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 151, 144),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 7, 0, 0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(mobAvatar(
                                        mob != null ? mob!.mobName : 'N/A')),
                                    radius: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      mob != null ? mob!.mobName : 'N/A',
                                      style: const TextStyle(fontSize: 26),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Level: ${mob != null ? mob!.level : 'N/A'}, XP: ${mob != null ? mob!.xp : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${mob != null ? mob!.health : 'N/A'}, Armor: ${mob != null ? mob!.armor : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${mob != null ? mob!.attack : 'N/A'}, Crit: ${mob != null ? mob!.criticalAttack : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${mob != null ? mob!.luck : 'N/A'}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  if (!buttonIsDisabled) {
                    initiateFight(selectedCharacterID, selectedMobID, 'attack');
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(winner),
                          content: const Text('The game is now over'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CharacterSelect(),
                                  ),
                                );
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
                      : const Color.fromARGB(255, 191, 254, 207),
                ),
                child: Text(
                  buttonIsDisabled ? 'Game over' : 'Fight!',
                  style: TextStyle(
                    fontSize: 18,
                    color: buttonIsDisabled
                        ? const Color.fromARGB(255, 255, 17, 0)
                        : const Color.fromARGB(255, 55, 133, 58),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (!buttonIsDisabled) {
                    initiateFight(selectedCharacterID, selectedMobID, 'escape');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 76, 227, 81),
                ),
                child: const Icon(Icons.run_circle,
                    color: Color.fromARGB(255, 255, 17, 0)),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
