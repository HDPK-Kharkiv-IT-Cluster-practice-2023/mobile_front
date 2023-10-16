import 'package:fightingapp/gamemode_select.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fetch_character.dart';

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
    'assets/character5.png'
  ];

  Future<void> fetchData() async {
    final url = Uri.parse('http://127.0.0.1:5000/characterslist');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response into a List<dynamic>
      List<dynamic> jsonList = json.decode(response.body);
      await Future.delayed(Duration(milliseconds: 250));

      // Parse the JSON data into a list of Character objects
      characters = jsonList.map((jsonRow) {
        List<dynamic> row = jsonRow as List;
        return Character(
          id: row[0] as int,
          name: row[1] as String,
          criticalAttack: row[2] as int,
          health: row[3] as int,
          armor: row[4] as int,
          attack: row[5] as int,
          luck: row[6] as int,
          level: row[7] as int,
          xp: row[8] as int,
          balance: row[9] as int,
          alive: row[10] as bool,
          playability: row[11] as bool,
          maxHealth: row[12] as int,
        );
      }).toList();

      setState(() {}); // Update the UI with the fetched data
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  Future<void> createCharacter() async {
    final url = 'http://127.0.0.1:5000/addcharacter';
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

  Future<void> selectCharacter(int index) async {
    final url = 'http://127.0.0.1:5000/selectcharacter';
    final postData = {
      'post': index.toString(),
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
                              selectCharacter(index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GMSelector()),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 9, 0, 0),
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
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 151, 144),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createCharacter();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Customize the button color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
