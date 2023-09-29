import 'dart:convert';
import 'dart:io';

final character1Url = 'http://127.0.0.1:5000/character1';
final character2Url = 'http://127.0.0.1:5000/character2';

var currentLvl = 5;

class Character {
  String name;
  int level;
  int xp;
  int health;
  int armor;
  int attack;
  int luck;
  int balance;
  bool alive;
  int criticalAttack;

  Character({
    required this.name,
    required this.level,
    required this.xp,
    required this.health,
    required this.armor,
    required this.attack,
    required this.luck,
    required this.balance,
    required this.alive,
    required this.criticalAttack,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
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
      balance: json['balance'] as int? ??
          0, // Provide a default value and cast to int
      alive: json['alive'] as bool? ??
          false, // Provide a default value and cast to bool
      criticalAttack: json['critical_attack'] as int? ??
          0, // Provide a default value and cast to int
    );
  }
}

Character? character1;
Character? character2;

Future<Character?> fetchCharacter(String url) async {
  final response = await HttpClient().getUrl(Uri.parse(url));
  final httpResponse = await response.close();
  final responseBody = await utf8.decodeStream(httpResponse);

  final Map<String, dynamic> jsonData = json.decode(responseBody);

  return Character.fromJson(jsonData);
}
