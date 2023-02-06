void main() {
  var map1 = {
    'name': 'tw',
    'xp': 19.99,
    'superpower': false,
  };

  print(map1['name']);
  print(map1['xp']);
  print(map1['superpower']);

  Map<int, bool> map2 = {
    1: true,
    2: false,
    3: true,
  };

  Map<List<int>, bool> map3 = {
    [1, 2, 3, 5]: true,
  };

  print("$map2");
  if (map2.containsKey(1)) print(map2[1]);
  for (final e in map2.entries) {
    print('${e.key} = ${e.value}');
  }

  map3[[1, 2, 3, 5]] = false;
  print("$map3");

  var map4 = Map();
  map4['name'] = 'tw';
  map4['age'] = 30;
  print(map4);
}
