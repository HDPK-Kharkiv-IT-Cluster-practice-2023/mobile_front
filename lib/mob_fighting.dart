import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'fetch_character.dart';
import 'package:http/http.dart' as http;

class FightingMobs extends StatefulWidget {
  const FightingMobs({Key? key}) : super(key: key);

  @override
  _FightingMobsState createState() => _FightingMobsState();
}

class _FightingMobsState extends State<FightingMobs> {
  Map<String, dynamic> character1Data = {};
  Map<String, dynamic> mobData = {};

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        character1Data = data['character1Data'];
        mobData = data['mobData'];
      });
    }).catchError((error) {
      // Обработка ошибки, если необходимо
    });
  }

  Future<void> fight() async {
    final url = Uri.parse('http://127.0.0.1:5000/fight_character');
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
          mobData = updatedData['character2Data'];
        });
      } catch (error) {
        // Обработка ошибки, если необходимо
      }
    } else {
      // Обработайте ошибку, если необходимо
    }
  }

  @override
  Widget build(BuildContext context) {
    var character1Hp =
        character1Data != null ? character1Data['health'] ?? 0 : 0;

    var character2Hp = mobData != null ? mobData['health'] ?? 0 : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PvE'),
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
                        animation: false,
                        percent: character1Hp >= 0 ? character1Hp / 100 : 0,
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
                    'Luck: ${character1Data != null ? character1Data['luck'] ?? 'N/A' : 'N/A'}, Balance: ${character1Data != null ? character1Data['balance'] ?? 'N/A' : 'N/A'} \$',
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
                              animation: false,
                              percent:
                                  character2Hp >= 0 ? character2Hp / 100 : 0,
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
                                      mobData != null
                                          ? mobData['name'] ?? 'N/A'
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
                    'Level: ${mobData != null ? mobData['level'] ?? 'N/A' : 'N/A'}, XP: ${mobData != null ? mobData['xp'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Health: ${mobData != null ? mobData['health'] ?? 'N/A' : 'N/A'}, Armor: ${mobData != null ? mobData['armor'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Attack: ${mobData != null ? mobData['attack'] ?? 'N/A' : 'N/A'}, Crit: ${mobData != null ? mobData['critical_attack'] ?? 'N/A' : 'N/A'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Luck: ${mobData != null ? mobData['luck'] ?? 'N/A' : 'N/A'}',
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
                          255, 191, 254, 207), // Background color
                    ),
                    child: const Text(
                      'Fight mob!',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 55, 133, 58)),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
