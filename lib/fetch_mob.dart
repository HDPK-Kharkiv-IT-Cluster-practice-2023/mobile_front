import 'dart:convert';
import 'dart:io';

class Mob {
  int id;
  String mobName;
  int level;
  int xp;
  int maxHealth;
  int health;
  int armor;
  int attack;
  int luck;
  int balance;
  bool alive;
  int criticalAttack;
  bool playability;
  int xpGoal = 100;

  Mob({
    required this.id,
    required this.mobName,
    required this.level,
    required this.xp,
    required this.maxHealth,
    required this.health,
    required this.armor,
    required this.attack,
    required this.luck,
    required this.balance,
    required this.alive,
    required this.criticalAttack,
    required this.playability,
  }) {
    xpGoal = calculateXpByLevel(level);
  }

  int calculateXpByLevel(int level) {
    int baseXpGoal = 100;
    return baseXpGoal + (level - 1) * 25;
  }

  factory Mob.fromJson(Map<String, dynamic> json) {
    return Mob(
        id: json['id'] ?? 'N/A',
        mobName: json['mob_name'] ?? 'N/A',
        criticalAttack: json['critical_attack'] as int? ?? 0,
        health: json['health'] as int? ?? 0,
        armor: json['armor'] as int? ?? 0,
        attack: json['attack'] as int? ?? 0,
        luck: json['luck'] as int? ?? 0,
        level: json['level'] as int? ?? 0,
        xp: json['xp'] as int? ?? 0,
        balance: json['balance'] as int? ?? 0,
        alive: json['alive'] as bool? ?? false,
        playability: json['playability'] as bool? ?? false,
        maxHealth: json['maxHealth'] as int? ?? 0);
  }
}

Mob? character1;
Mob? character2;

Future<Mob?> fetchCharacter(String url) async {
  final response = await HttpClient().getUrl(Uri.parse(url));
  final httpResponse = await response.close();
  final responseBody = await utf8.decodeStream(httpResponse);

  final Map<String, dynamic> jsonData = json.decode(responseBody);

  return Mob.fromJson(jsonData);
}

Mob? mob;

Future<Mob?> fetchMob(String url) async {
  final response = await HttpClient().getUrl(Uri.parse(url));
  final httpResponse = await response.close();
  final responseBody = await utf8.decodeStream(httpResponse);

  final Map<String, dynamic> jsonData = json.decode(responseBody);

  return Mob.fromJson(jsonData);
}
