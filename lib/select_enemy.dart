// ignore_for_file: avoid_print

import 'package:fightingapp/main.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fetch_character.dart';
import 'fight_navigation_bar.dart';
import 'dart:math';

int selectedEnemyID = 0;
void main() => runApp(const ESelector());

class ESelector extends StatelessWidget {
  const ESelector({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const NavigationExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  List<Character> characters = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<String> characterArray = [
    'assets/character0.png',
    'assets/character1.png',
    'assets/character2.png',
    'assets/character3.png',
    'assets/character4.png',
    'assets/character5.png'
  ];

  Future<void> fetchData() async {
    final url = Uri.parse('http://$currentServer/api/v1/characters/false');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response into a List<dynamic>
      List<dynamic> jsonList = json.decode(response.body);
      await Future.delayed(const Duration(milliseconds: 250));

      // Parse the JSON data into a list of Character objects and update the class-level characters list
      characters = jsonList.map((jsonCharacter) {
        Map<String, dynamic> characterData =
            jsonCharacter as Map<String, dynamic>;
        return Character(
          id: characterData['id'] as int,
          name: characterData['name'] as String,
          criticalAttack: characterData['critical_attack'] as int,
          health: characterData['health'] as int,
          armor: characterData['armor'] as int,
          attack: characterData['attack'] as int,
          luck: characterData['luck'] as int,
          level: characterData['level'] as int,
          xp: characterData['xp'] as int,
          balance: characterData['balance'] as int,
          alive: characterData['alive'] as bool,
          playability: characterData['playability'] as bool,
          maxHealth: characterData['max_health'] as int,
        );
      }).toList();

      setState(() {}); // Update the UI with the fetched data
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  Future<void> createEnemy() async {
    try {} catch (error) {
      print('Network error during fight: $error');
    }
    await fetchData();
    setState(() {});
  }

  Future<void> sendCharacterData({
    bool alive = true,
    required int level,
    bool playability = false,
  }) async {
    final apiUrl = Uri.parse('http://$currentServer/api/v1/character');
    final characterData = {
      "alive": alive,
      "level": level,
      "playability": playability,
    };

    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: headers,
        body: json.encode(characterData),
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
        title: const Text('Character selection'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              sendCharacterData(level: 5);
            },
            icon: const Icon(Icons.add),
            iconSize: 35,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            Character character = characters[index];

            double calculatePercentage() {
              if (character.xpGoal == 0) {
                return 0.0; // Avoid division by zero
              }

              return character.xp / character.xpGoal;
            }

            int mapToRange1To5() {
              // Use modulo to wrap the input within the range [1, 5]
              double mappedValue = (character.id - 1) % 5 + 1;
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
                                    percent: character.health >= 0
                                        ? character.health / 100
                                        : 0,
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
                                        backgroundImage: AssetImage(
                                            characterArray[mapToRange1To5()]),
                                        radius: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              character.name,
                                              style:
                                                  const TextStyle(fontSize: 26),
                                            ),
                                            LinearPercentIndicator(
                                              width: 100.0,
                                              lineHeight: 8.0,
                                              percent: calculatePercentage(),
                                              leading: Text(
                                                  "Lvl ${character.level}"),
                                              trailing: Text(
                                                  "Lvl ${character.level + 1}"),
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
          if (characters.isNotEmpty) {
            final random = Random();
            final randomIndex = random.nextInt(characters.length);
            selectedEnemyID = characters[randomIndex].id;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavigationBarApp()),
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
