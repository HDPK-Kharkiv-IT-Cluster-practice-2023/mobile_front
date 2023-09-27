import 'fetch_character.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'fighting_action.dart';

final mobURL = 'http://127.0.0.1:5000/mob';

class Mob {
  int level;
  int xp;
  String name;
  int health;
  int armor;
  int attack;
  int luck;
  bool alive;
  double criticalAttack;

  Mob({
    required this.level,
    required this.xp,
    required this.name,
    required this.health,
    required this.armor,
    required this.attack,
    required this.luck,
    required this.alive,
    required this.criticalAttack,
  });
  factory Mob.fromJson(Map<String, dynamic> json) {
    return Mob(
      name: json['name'] ?? 'N/A', // Provide a default value for 'name'
      level:
          json['level'] as int? ?? 0, // Provide a default value and cast to int
      xp: json['xp'] as int? ?? 0, // Provide a default value and cast to int
      health: json['health'] as int? ??
          0, // Provide a default value and cast to int
      armor:
          json['armor'] as int? ?? 0, // Provide a default value and cast to int
      attack: json['attack'] as int? ??
          0, // Provide a default value and cast to int
      luck:
          json['luck'] as int? ?? 0, // Provide a default value and cast to int
      alive: json['alive'] as bool? ??
          false, // Provide a default value and cast to bool
      criticalAttack: json['criticalAttack'] as double? ??
          0.0, // Provide a default value and cast to double
    );
  }
}

Mob? mob;

Future<Mob?> fetchMob(String url) async {
  final response = await HttpClient().getUrl(Uri.parse(url));
  final httpResponse = await response.close();
  final responseBody = await utf8.decodeStream(httpResponse);

  final Map<String, dynamic> jsonData = json.decode(responseBody);

  return Mob.fromJson(jsonData);
}
