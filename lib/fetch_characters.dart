class Character {
  int id;
  String name;
  int criticalAttack;
  int health;
  int armor;
  int attack;
  int luck;
  int level;
  int xp;
  int balance;
  bool alive;
  bool playability;
  int maxHealth;
  int xpGoal = 100;

  Character({
    required this.id,
    required this.name,
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
}
