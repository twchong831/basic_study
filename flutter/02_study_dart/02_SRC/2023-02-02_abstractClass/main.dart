abstract class Human {
  void walk();
}

enum TEAM { red, blue }

class Player extends Human {
  String name;
  int xp;
  TEAM team;

  Player({required this.name, required this.xp, required this.team});

  void sayHello() {
    print("Hi[json] my name is $name");
    print("\txp : $xp");
    print("\team : $team");
  }

  void walk() {
    print('$name Player walking..');
  }
}

void main(List<String> args) {
  var tw = Player(name: 'tw', xp: 20, team: TEAM.red)
    ..sayHello()
    ..name = 'tw2'
    ..xp = 3000
    ..team = TEAM.blue
    ..sayHello();
}
