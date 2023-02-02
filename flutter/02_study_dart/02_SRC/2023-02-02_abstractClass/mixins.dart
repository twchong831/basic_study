class Strong {
  final double strengthLevel = 1500.99;
}

class QuickRunner {
  void runQuick() {
    print("runnnnn");
  }
}

class Tall {
  final double height = 1.99;
}

enum TEAM {
  red,
  blue,
}

class Player with Strong, QuickRunner, Tall {
  final TEAM team;

  Player({
    required this.team,
  });
}

class Horse with Strong, QuickRunner {}

class Kid with QuickRunner {}

void main(List<String> args) {
  var player = Player(
    team: TEAM.red,
  );

  player.runQuick();
}
