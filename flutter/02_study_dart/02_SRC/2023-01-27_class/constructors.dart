class Player {
  late final String name;
  late int xp;

  Player(String name, int xp) {
    this.name = name;
    this.xp = xp;
  }

  void sayHello() {
    print("Hi my name is $name");
  }
}

class Player2 {
  final String name;
  int xp;

  Player2(this.name, this.xp);

  void sayHello() {
    print("Hi my name is $name");
  }
}

void main(List<String> args) {
  var player = Player("name,tw", 1500);
  // print(player.name);
  var player2 = Player("name, t22t", 200);
  player.sayHello();
  player2.sayHello();

  var player3 = Player2("name:twtw", 2000);
  player3.sayHello();
}
