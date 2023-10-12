import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class FightingAction extends StatefulWidget {
  const FightingAction({super.key});

  @override
  _FightingActionState createState() => _FightingActionState();
}

class _FightingActionState extends State<FightingAction> {
  @override
  void initState() {
    super.initState();
    fetchCharacters(); // Call the fetchCharacters method here to initialize character1 and character2.
  }

  Future<void> fetchCharacters() async {
    try {
      character1 = await fetchCharacter(character1Url);
    } catch (e) {
      print('Error fetching character 1: $e');
    }

    try {
      character2 = await fetchCharacter(character2Url);
    } catch (e) {
      print('Error fetching character 2: $e');
    }
    setState(() {});
  }

  Future<void> fight() async {
    final url = 'http://127.0.0.1:5000/fight_character';
    final postData = {
      'c1damage':
          'damage', // Replace 'damage' with the actual damage you want to send
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: postData,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        // After the fight, update character data
        try {
          character1 = await fetchCharacter(character1Url);
        } catch (error) {
          print('Error updating character data: $error');
        }
        try {
          character2 = await fetchCharacter(character2Url);
        } catch (error) {
          print('Error updating character data: $error');
        }
      } else {
        print('Error during fight: HTTP ${response.statusCode}');
      }
    } catch (error) {
      print('Network error during fight: $error');
    }
    await fetchCharacters();
    setState(() {});
  }

  Future<void> initCharacters() async {
    final url = 'http://127.0.0.1:5000/init';
    final postData = {
      'init': 'init',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: postData,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        try {
          character1 = await fetchCharacter(character1Url);
        } catch (error) {
          print('Error updating character data: $error');
        }
        try {
          character2 = await fetchCharacter(character2Url);
        } catch (error) {
          print('Error updating character data: $error');
        }
      } else {
        print('Error during fight: HTTP ${response.statusCode}');
      }
    } catch (error) {
      print('Network error during fight: $error');
    }
    await fetchCharacters();
    setState(() {});
  }

  Future<Character?> fetchCharacter(String url) async {
    final response = await HttpClient().getUrl(Uri.parse(url));
    final httpResponse = await response.close();
    final responseBody = await utf8.decodeStream(httpResponse);

    final Map<String, dynamic> jsonData = json.decode(responseBody);

    return Character.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    var character1Hp = character1 != null ? character1!.health : 0;
    var character2Hp = character2 != null ? character2!.health : 0;

    var winner = "";
    var buttonIsDisabled = false;

    if (character1 != null && character1!.health <= 0) {
      winner = character2 != null ? character2!.name : 'N/A';
      buttonIsDisabled = true;
    }

    if (character2 != null && character2!.health <= 0) {
      winner = character1 != null ? character1!.name : 'N/A';
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
                            backgroundImage:
                                AssetImage("assets/character2.png"),
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
                                    leading: new Text("Lvl ${currentLvl}"),
                                    trailing: new Text("Lvl ${currentLvl + 1}"),
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
                  // Character2 avatar, Name, Healthbar padding.
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
                            percent: character2Hp >= 0 ? character2Hp / 100 : 0,
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
                                    character2 != null
                                        ? character2!.name
                                        : 'N/A',
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
                  'Level: ${character2 != null ? character2!.level : 'N/A'}, XP: ${character2 != null ? character2!.xp : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Health: ${character2 != null ? character2!.health : 'N/A'}, Armor: ${character2 != null ? character2!.armor : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Attack: ${character2 != null ? character2!.attack : 'N/A'}, Crit: ${character2 != null ? character2!.criticalAttack : 'N/A'}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Luck: ${character2 != null ? character2!.luck : 'N/A'}, Balance: ${character2 != null ? character2!.balance : 'N/A'} \$',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            child: FilledButton(
              onPressed: () {
                if (!buttonIsDisabled) {
                  fight();
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
                              initCharacters();
                              Navigator.pop(context, 'New Game');
                            },
                            child: const Text('New Game'),
                          ),
                          TextButton(
                            onPressed: () {
                              initCharacters();
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
                    : Color.fromARGB(255, 253, 231, 255),
              ),
              child: Text(
                buttonIsDisabled ? 'Game over' : 'Fight!',
                style: TextStyle(
                  fontSize: 18,
                  color: buttonIsDisabled
                      ? Color.fromARGB(255, 255, 17, 0)
                      : Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
