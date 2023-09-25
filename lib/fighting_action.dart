import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';

class FightingAction extends StatefulWidget {
  const FightingAction({super.key});

  @override
  _FightingActionState createState() => _FightingActionState();
}

class _FightingActionState extends State<FightingAction> {
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



  // NEW CODE
  Future<void> fight() async {
    final url = Uri.parse('http://192.168.1.9:5000/fight_character');
    final postData = {
      'c1damage': 'damage',
      // Замените 'damage' на фактический урон, который вы хотите отправить
    };

    final response = await http.post(
      url,
      body: postData,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (response.statusCode == 200) {
      // Обработайте успешный ответ, если необходимо


        // После боя, обновите характеристики персонажей
        try {
          final updatedData = await fetchData();
          setState(() {
            character1Data = updatedData['character1Data'];
            character2Data = updatedData['character2Data'];
          });
        } catch (error) {
          // Обработка ошибки, если необходимо
        }
      } else {
        // Обработайте ошибку, если необходимо
      }

  }

//NEW CODE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Kick'),
        titleTextStyle: null,
        actions: const <Widget>[],
        backgroundColor: null,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Stack(children: [
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: 0.65,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Color.fromARGB(255, 144, 218, 146),
                        backgroundColor:
                        const Color.fromARGB(255, 255, 151, 144),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 7, 0, 0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                              AssetImage("assets/character2.png"),
                              radius: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                character1Data != null
                                    ? character1Data['name'] ?? 'N/A'
                                    : 'N/A',
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                  Text(
                    'Level: ${character1Data != null ? character1Data['level'] ?? 'N/A' : 'N/A'}, XP: ${character1Data != null ? character1Data['xp'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Health: ${character1Data != null ? character1Data['health'] ?? 'N/A' : 'N/A'}, Armor: ${character1Data != null ? character1Data['armor'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Attack: ${character1Data != null ? character1Data['attack'] ?? 'N/A' : 'N/A'}, Crit: ${character1Data != null ? character1Data['critical_attack'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Luck: ${character1Data != null ? character1Data['luck'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Balance: ${character1Data != null ? character1Data['balance'] ?? 'N/A' : 'N/A'} \$',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    // Character2 avatar, Name, Healthbar padding.
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Stack(children: [
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: 0.65,
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
                                      character2Data != null
                                          ? character2Data['name'] ?? 'N/A'
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
                    'Level: ${character2Data != null ? character2Data['level'] ?? 'N/A' : 'N/A'}, XP: ${character2Data != null ? character2Data['xp'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Health: ${character2Data != null ? character2Data['health'] ?? 'N/A' : 'N/A'}, Armor: ${character2Data != null ? character2Data['armor'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Attack: ${character2Data != null ? character2Data['attack'] ?? 'N/A' : 'N/A'}, Crit: ${character2Data != null ? character2Data['critical_attack'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Luck: ${character2Data != null ? character2Data['luck'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Balance: ${character2Data != null ? character2Data['balance'] ?? 'N/A' : 'N/A'} \$',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  child: FilledButton(
                    onPressed: fight,
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 253, 231, 255), // Background color
                    ),
                    child: const Text(
                      'Fight!',
                      style: TextStyle(fontSize: 18, color: Colors.purple),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
