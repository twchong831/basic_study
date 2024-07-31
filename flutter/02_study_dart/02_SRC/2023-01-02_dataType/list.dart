void main() {
  var numbers = [1, 2, 3, 4];
  // List<int> numbers = [1, 2, 3, 4];
  numbers.add(12);

  var num2 = [
    1,
    2,
    3,
    4,
  ]; // 마지막에 ,를 추가하면 위와 같이 정렬해줌

  // list-- collection if
  bool giveMeFive = true;
  var l_num = [
    1,
    2,
    3,
    4,
    if (giveMeFive) 5,
  ];
  print(l_num);
}
