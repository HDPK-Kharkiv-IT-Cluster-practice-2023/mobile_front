import 'package:fightingapp/gamemode_select.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fetch_character.dart';
import 'main.dart';

int selectedCharacterID = 0;

void main() => runApp(const CharacterSelection());

class CharacterSelection extends StatelessWidget {
  const CharacterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: NavigationExample(),
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
    'assets/character5.png',
  ];

  Future<void> fetchData() async {
    final url = Uri.parse('http://${currentServer}/api/v1/characters/true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response into a List<dynamic>
      List<dynamic> jsonList = json.decode(response.body);
      await Future.delayed(Duration(milliseconds: 250));

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

  Future<void> createCharacter() async {
    final url = 'http://${currentServer}/addcharacter';
    final postData = {
      'post': 'post',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: postData,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );
    } catch (error) {
      print('Network error during fight: $error');
    }
    await fetchData();
    setState(() {});
  }

  Future<void> sendCharacterData({
    bool alive = true,
    required int armor,
    required int attack,
    int balance = 0,
    required int criticalAttack,
    required int health,
    required int level,
    required int luck,
    required int maxHealth,
    required String name,
    bool playability = true,
    int statPoints = 1,
    int xp = 0,
  }) async {
    final apiUrl = Uri.parse(
        'http://$currentServer/api/v1/character'); // Replace with your API endpoint
    final characterData = {
      "alive": alive,
      "armor": armor,
      "attack": attack,
      "balance": balance,
      "critical_attack": criticalAttack,
      "health": health,
      "level": level,
      "luck": luck,
      "max_health": maxHealth,
      "name": name,
      "playability": playability,
      "stat_points": statPoints,
      "xp": xp,
    };

    final headers = {
      "Content-Type": "application/json", // Set the content type to JSON
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
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          onPressed: () {
                            selectedCharacterID = character.id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GMSelector(),
                              ),
                            );
                          },
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 9, 0, 0),
                                child: CircularPercentIndicator(
                                  radius: 40.0,
                                  lineWidth: 13.0,
                                  animation: false,
                                  percent: character.health >= 0
                                      ? character.health / 100
                                      : 0,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor:
                                      Color.fromARGB(255, 144, 218, 146),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 151, 144),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          characterArray[mapToRange1To5()]),
                                      radius: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            character.name,
                                            style: TextStyle(fontSize: 26),
                                          ),
                                          LinearPercentIndicator(
                                            width: 100.0,
                                            lineHeight: 8.0,
                                            percent: calculatePercentage(),
                                            leading:
                                                Text("Lvl ${character.level}"),
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
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendCharacterDataDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Customize the button color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  // Function to show an alert dialog with input fields for character parameters
  Future<void> sendCharacterDataDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController healthController = TextEditingController();
    final TextEditingController armorController = TextEditingController();
    final TextEditingController attackController = TextEditingController();
    final TextEditingController criticalAttackController =
        TextEditingController();
    final TextEditingController levelController = TextEditingController();
    final TextEditingController luckController = TextEditingController();
    final TextEditingController maxHealthController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Character Parameters'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name')),
                TextField(
                    controller: healthController,
                    decoration: InputDecoration(labelText: 'Health')),
                TextField(
                    controller: armorController,
                    decoration: InputDecoration(labelText: 'Armor')),
                TextField(
                    controller: attackController,
                    decoration: InputDecoration(labelText: 'Attack')),
                TextField(
                    controller: criticalAttackController,
                    decoration: InputDecoration(labelText: 'Critical Attack')),
                TextField(
                    controller: levelController,
                    decoration: InputDecoration(labelText: 'Level')),
                TextField(
                    controller: luckController,
                    decoration: InputDecoration(labelText: 'Luck')),
                TextField(
                    controller: maxHealthController,
                    decoration: InputDecoration(labelText: 'Max Health')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                sendCharacterData(
                  name: nameController.text,
                  health: int.tryParse(healthController.text) ?? 0,
                  armor: int.tryParse(armorController.text) ?? 0,
                  attack: int.tryParse(attackController.text) ?? 0,
                  criticalAttack:
                      int.tryParse(criticalAttackController.text) ?? 0,
                  level: int.tryParse(levelController.text) ?? 0,
                  luck: int.tryParse(luckController.text) ?? 0,
                  maxHealth: int.tryParse(maxHealthController.text) ?? 0,
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
