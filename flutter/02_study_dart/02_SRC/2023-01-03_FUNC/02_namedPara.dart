String sayHello(String name, int age, String country) {
  return "Hello $name, you are $age, and you come from $country";
}

String sayHello2({
  String name = 'anon',
  int age = 99,
  String country = 'none',
}) {
  return "Hello $name, you are $age, and you come from $country";
}

String sayHello3({
  required String name,
  required int age,
  required String country,
}) {
  return "Hello $name, you are $age, and you come from $country";
}

void main() {
  print(sayHello('tw', 34, 'korea'));

  print(sayHello2(age: 12, country: 'korea', name: 'tw'));
  print(sayHello2()); //null safety

  print(sayHello3(name: 'name', age: 20, country: 'mango'));
}

// void main() {
//   print(sayHello("tw", 10, "korea"));
// }
