class Human {
  final String name;
  // Human(this.name);  // #1
  Human({required this.name});

  void sayHello() {
    print('hi my name is $name');
  }
}

enum TEAM {
  red,
  blue,
}

class Player extends Human {
  final TEAM team;

  Player({
    required this.team,
    required String name,
    // }) : super(name);  // #1
  }) : super(name: name);

  @override
  void sayHello() {
    super.sayHello();
    print('and I play for $TEAM');
  }
}

void main(List<String> args) {
  var player = Player(
    team: TEAM.red,
    name: 'tw',
  );
  player.sayHello();
}
