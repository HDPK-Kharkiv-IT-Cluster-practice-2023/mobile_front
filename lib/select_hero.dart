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
      home: CharacterSelect(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CharacterSelect extends StatefulWidget {
  const CharacterSelect({super.key});

  @override
  State<CharacterSelect> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<CharacterSelect> {
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

  // Future<void> createCharacter() async {
  //   final url = 'http://${currentServer}/addcharacter';
  //   final postData = {
  //     'post': 'post',
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: postData,
  //       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //     );
  //   } catch (error) {
  //     print('Network error during fight: $error');
  //   }
  //   await fetchData();
  //   setState(() {});
  // }

  Future<void> sendCharacterData({
    bool alive = true,
    required int armor,
    required int attack,
    int balance = 0,
    int criticalAttack = 0,
    required int health,
    required int level,
    required int luck,
    required int maxHealth,
    required String name,
    bool playability = true,
    int xp = 0,
  }) async {
    final apiUrl = Uri.parse('http://${currentServer}/api/v1/character');
    // Replace with your API endpoint
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

  Future<int> getMaxStatPoints(int level) async {
    final url = Uri.parse(
        'http://${currentServer}/api/v1/character/max_stat_points/$level');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['max_stat_points'];
    } else {
      throw Exception('Failed to fetch max_stat_points.');
    }
  }

  // Function to show an alert dialog with input fields for character parameters
  Future<void> sendCharacterDataDialog() async {
    final TextEditingController nameController = TextEditingController();
    double health = 1.0;
    double armor = 1.0;
    double attack = 1.0;
    double level = 1.0;
    double luck = 1.0;
    double maxHealth = 1.0;

    int maxStatPoints = 0;

    Future<void> updateMaxStatPoints() async {
      maxStatPoints = await getMaxStatPoints(level.toInt());
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Enter Character Parameters'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    _buildSliderWithTitle('Health', health, (value) {
                      setState(() {
                        if (health + armor + value + luck + maxHealth <=
                            maxStatPoints) {
                          health = value;
                        } else {
                          // Handle error or display a message here
                          // You can display a message like:
                          // 'Total stat points cannot exceed $maxStatPoints'
                        }
                      });
                    }),
                    _buildSliderWithTitle('Armor', armor, (value) {
                      setState(() {
                        if (health + armor + value + luck + maxHealth <=
                            maxStatPoints) {
                          armor = value;
                        } else {
                          // Handle error or display a message here
                        }
                      });
                    }),
                    _buildSliderWithTitle('Attack', attack, (value) {
                      setState(() {
                        if (health + armor + value + luck + maxHealth <=
                            maxStatPoints) {
                          attack = value;
                        } else {
                          // Handle error or display a message here
                        }
                      });
                    }),
                    _buildSliderWithTitle('Level', level, (value) {
                      setState(() {
                        level = value;
                      });
                      updateMaxStatPoints();
                    }),
                    _buildSliderWithTitle('Luck', luck, (value) {
                      setState(() {
                        if (health + armor + value + luck + maxHealth <=
                            maxStatPoints) {
                          luck = value;
                        } else {
                          // Handle error or display a message here
                        }
                      });
                    }),
                    _buildSliderWithTitle('Max Health', maxHealth, (value) {
                      setState(() {
                        if (health + armor + value + luck + maxHealth <=
                            maxStatPoints) {
                          maxHealth = value;
                        } else {
                          // Handle error or display a message here
                        }
                      });
                    }),
                    Text('Max Stat Points: $maxStatPoints'),
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
                      health: health.toInt(),
                      armor: armor.toInt(),
                      attack: attack.toInt(),
                      level: level.toInt(),
                      luck: luck.toInt(),
                      maxHealth: maxHealth.toInt(),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSliderWithTitle(
      String title, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text('$title: ${value.toInt()}'),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0,
          max: 100,
        ),
      ],
    );
  }
}
