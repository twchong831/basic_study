void sayHello(String name) {
  print("Hello $name nice to meet you");
}

String sayHello2(String potato) => "Hello $potato nice to meet you";

int sum(int a, int b) => a + b;

void main() {
  sayHello("tw");
  print(sayHello2("twtw"));

  print(sum(1, 2));
}
