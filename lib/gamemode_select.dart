import 'package:fightingapp/gamemode_select.dart';
import 'package:fightingapp/select_enemy.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GMSelector extends StatelessWidget {
  const GMSelector({super.key});

  Future<void> selectMode(int index) async {
    final url = 'http://127.0.0.1:5000/selectmode';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select game mode'),
        titleTextStyle: null,
        actions: const <Widget>[],
        backgroundColor: null,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                selectMode(2);
              },
              child: Card(
                color: Colors.green,
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(child: Text('PVE')),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectMode(1);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ESelector()),
                );
              },
              child: Card(
                color: Colors.red,
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(child: Text('PVP')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
