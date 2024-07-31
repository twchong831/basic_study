class Player {
  String name = 'tw';
  int xp = 1500;

  void sayHello() {
    // 만약 해당 함수에서 선언한 변수명이 같은 경우에는
    // print("Hi my name is ${this.name"); 으로 사용
    print("Hi my name is $name");
  }
}

class Player_f {
  final String name = 'tw';
  int xp = 1500;
}

void main(List<String> args) {
  var player = Player();
  // new를 꼭 사용할 필요는 없음...
  // var player = new Player();
  print(player.name);
  player.name = 'tw2';
  print(player.name);

  player.sayHello();

  var player2 = Player_f();
  print(player2.name);
  // player2.name = "twtw";  //error for final var.
}
