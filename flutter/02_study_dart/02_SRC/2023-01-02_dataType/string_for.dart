/*
void main() {
  var name = 'tw';
  var age = 10;
  var greeting = "hello eberyone, my name is $name and I\'m ${age + 2}";

  print(greeting);
}
*/

void main() {
  var oldFriends = ['tw', 'cc'];
  var newFriends = [
    'lewis',
    'ralph',
    'darren',
    for (var friend in oldFriends) "$friend",
  ];
  print(newFriends);
}
