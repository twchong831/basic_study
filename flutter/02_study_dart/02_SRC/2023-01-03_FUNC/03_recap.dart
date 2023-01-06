String sayHello(String name, int age, String country) {
  return "Hello $name, you are $age, and you come from $country";
}

String sayHello2({
  String name = 'none',
  int age = 99,
  String country = 'any',
}) {
  return "Hello $name, you are $age, and you come from $country";
}

String sayHello3(String name, int age, [String? country = 'any']) =>
    "Hello $name, you are $age, and you come from $country";

void main() {
  print(sayHello("tw", 20, "korea")); // positional arguments

  //named arguments
  print(sayHello2(
    name: 'twtw',
    age: 30,
    country: 's-korea',
  ));

  //optional positional parameters
  print(sayHello3('tw3', 35));
}
