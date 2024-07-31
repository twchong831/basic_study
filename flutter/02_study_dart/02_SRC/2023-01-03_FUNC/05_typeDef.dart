typedef ListOfInts = List<int>;

List<int> reverseList(List<int> list) {
  var reversed = list.reversed;
  return reversed.toList();
}

typedef UserInfo = Map<String, String>;

String sayHi(UserInfo userInfo) {
  return "Hi ${userInfo['name']}";
}

void main() {
  print(reverseList([1, 2, 34, 5]));
  print(sayHi({"name": 'tw'}));
}
