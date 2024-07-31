// cascade notation
class Player {
  String name;
  int xp;
  String team;

  Player({required this.name, required this.xp, required this.team});

  void sayHello() {
    print("Hi my name is $name");
    print("\txp : $xp");
    print("\tteam : $team");
  }
}

void main(List<String> args) {
  var tw = Player(name: 'tw', xp: 1200, team: 'red');
  tw.name = 'tw-1';
  tw.xp = 10;
  tw.team = 'blue';
  tw.sayHello();

  var tw2 = Player(name: 'tw2', xp: 100, team: 'blue')
    ..name = "tw2-2"
    ..xp = 10000
    ..team = 'red'
    ..sayHello();

  var potato = tw2
    ..name = 'potato'
    ..xp = 2003
    ..team = 'black'
    ..sayHello();
}
