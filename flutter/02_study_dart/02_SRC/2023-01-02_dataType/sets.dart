void main() {
  Set<int> setnum = {1, 2, 3, 4};
  setnum.add(1);
  setnum.add(2);
  setnum.add(5);

  var numbers = {1, 2, 3, 4};
  // same set
  numbers.add(2);
  numbers.add(1);
  numbers.add(3);

  print('setnum : $setnum');
  print('numbers : $numbers');
  // set을 사용하면 같은 값을 추가하더라도
  // 자체적으로 추가되지 않음.

  // List<int> numbers2 = [1, 2, 3, 4];
  var numbers2 = [1, 2, 3, 4];
  // same list
  numbers2.add(1);
  numbers2.add(1);
  print('list numbers2 : $numbers2');
  // list을 사용하는 경우
  // add항목이 중복되더라도 추가됨
}
