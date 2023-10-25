// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:fightingapp/select_enemy.dart';
import 'package:flutter/material.dart';
import 'select_mob.dart';

String enemy_type = '';

class GMSelector extends StatelessWidget {
  const GMSelector({super.key});

  Future<void> selectMode(int index) async {
    try {} catch (error) {
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
                enemy_type = 'mob';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MSelector()),
                );
              },
              child: const Card(
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
                enemy_type = 'character';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ESelector()),
                );
              },
              child: const Card(
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
