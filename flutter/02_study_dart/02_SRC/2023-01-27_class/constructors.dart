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

//constructors named parameters
class Player3 {
  final String name;
  int xp;
  String team;
  int age;

  Player3({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  });

  void sayHello() {
    print("Hi my name is $name");
    print("\txp : $xp");
    print("\team : $team");
    print("\tage : $age");
  }
}

//named constructors.
class Player4_color {
  final String name;
  int xp, age;
  String team;

  Player4_color({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  });

  Player4_color.createBluePlayer({
    required String name,
    required int age,
  })  : this.age = age,
        this.name = name,
        this.team = 'blue',
        this.xp = 0;

  Player4_color.createRedPlayer(String name, int age)
      : this.age = age,
        this.name = name,
        this.team = 'red',
        this.xp = 0;

  void sayHello() {
    print("Hi my name is $name");
    print("\txp : $xp");
    print("\team : $team");
    print("\tage : $age");
  }
}

//json
class Player5_json {
  final String name;
  int xp;
  String team;

  Player5_json.fromJson(Map<String, dynamic> playerJson)
      : name = playerJson['name'],
        xp = playerJson['xp'],
        team = playerJson['team'];

  void sayHello() {
    print("Hi[json] my name is $name");
    print("\txp : $xp");
    print("\team : $team");
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

  //----------------------
  // var player4 = Player3("twtww2", 1000, "red", 30);
  var player4 = Player3(
    name: "twtww2",
    xp: 1000,
    team: "red",
    age: 30,
  );

  player4.sayHello();

  //---------------------
  var blu_player = Player4_color.createBluePlayer(
    name: "tw(blue)",
    age: 30,
  );

  var red_player = Player4_color.createRedPlayer("tw(red)", 30);

  blu_player.sayHello();
  red_player.sayHello();

  //----------------------
  var apiData = [
    {
      "name": "tw",
      "team": "red",
      "xp": 0,
    },
    {
      "name": "tw2",
      "team": "red",
      "xp": 0,
    },
    {
      "name": "tw3",
      "team": "red",
      "xp": 0,
    },
  ];

  apiData.forEach((playerJson) {
    var playerJ = Player5_json.fromJson(playerJson);
    playerJ.sayHello();
  });
}
