// ignore_for_file: avoid_print, unused_element

import 'package:fightingapp/main.dart';
import 'package:fightingapp/mob_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'fetch_mob.dart';
import 'select_hero.dart';

int selectedMobID = 0;
void main() => runApp(const MSelector());

class MSelector extends StatelessWidget {
  const MSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MobSelect(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MobSelect extends StatefulWidget {
  const MobSelect({super.key});

  @override
  State<MobSelect> createState() => _MobSelectState();
}

class _MobSelectState extends State<MobSelect> {
  List<Mob> mobs = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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

  Future<void> fetchData() async {
    final url = Uri.parse('http://$currentServer/api/v1/mobs');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response into a List<dynamic>
      List<dynamic> jsonList = json.decode(response.body);
      await Future.delayed(const Duration(milliseconds: 250));

      // Parse the JSON data into a list of Character objects and update the class-level characters list
      mobs = jsonList.map((jsonCharacter) {
        Map<String, dynamic> characterData =
            jsonCharacter as Map<String, dynamic>;
        return Mob(
          id: characterData['id'] ?? 'N/A',
          mobName: characterData['mob_name'] ?? 'N/A',
          criticalAttack: characterData['critical_attack'] as int? ?? 0,
          health: characterData['health'] as int? ?? 0,
          armor: characterData['armor'] as int? ?? 0,
          attack: characterData['attack'] as int? ?? 0,
          luck: characterData['luck'] as int? ?? 0,
          level: characterData['level'] as int? ?? 0,
          xp: characterData['xp'] as int? ?? 0,
          balance: characterData['balance'] as int? ?? 0,
          alive: characterData['alive'] as bool? ?? false,
          playability: characterData['playability'] as bool? ?? false,
          maxHealth: characterData['maxHealth'] as int? ?? 0,
        );
      }).toList();

      setState(() {}); // Update the UI with the fetched data
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  Future<void> createMob() async {
    final apiUrl =
        Uri.parse('http://$currentServer/api/v1/mob/$selectedCharacterID');

    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("Character data sent successfully.");
        // You can handle the response here if needed.
      } else {
        print(
            "Failed to send character data. Status code: ${response.statusCode}");
        // Handle the error here.
      }
    } catch (e) {
      print("Error sending character data: $e");
      // Handle the exception here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mob selection'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              createMob();
            },
            icon: const Icon(Icons.add),
            iconSize: 35,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: mobs.length,
          itemBuilder: (context, index) {
            Mob mob = mobs[index];

            double calculatePercentage() {
              if (mob.xpGoal == 0) {
                return 0.0; // Avoid division by zero
              }

              return mob.xp / mob.xpGoal;
            }

            int mapToRange1To5() {
              // Use modulo to wrap the input within the range [1, 5]
              double mappedValue = (mob.id - 1) % 5 + 1;
              return mappedValue.toInt();
            }

            return Card(
              child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Stack(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 9, 0, 0),
                                  child: CircularPercentIndicator(
                                    radius: 40.0,
                                    lineWidth: 13.0,
                                    animation: false,
                                    percent:
                                        mob.health >= 0 ? mob.health / 100 : 0,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: const Color.fromARGB(
                                        255, 144, 218, 146),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 151, 144),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage(mobAvatar(mob.mobName)),
                                        radius: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mob.mobName,
                                              style:
                                                  const TextStyle(fontSize: 26),
                                            ),
                                            LinearPercentIndicator(
                                              width: 100.0,
                                              lineHeight: 8.0,
                                              percent:
                                                  calculatePercentage() >= 1.0
                                                      ? 1.0
                                                      : calculatePercentage(),
                                              leading: Text("Lvl ${mob.level}"),
                                              trailing:
                                                  Text("Lvl ${mob.level + 1}"),
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
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (mobs.isNotEmpty) {
            final random = Random();
            final randomIndex = random.nextInt(mobs.length);
            selectedMobID = mobs[randomIndex].id;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MobNavigationBarApp()),
            );
          }
        },
        label: const Text('Play'),
        icon: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
