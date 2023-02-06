String capitalizeName(String name) => name.toUpperCase();

String capitalizeName2(String? name) {
  if (name != null) {
    return name.toUpperCase();
  }
  return 'NONE';
}

String capitalizeName3(String? name) =>
    name != null ? name.toUpperCase() : 'NONE2';

String capitalizeName4(String? name) => name?.toUpperCase() ?? 'None3';

void main() {
  print(capitalizeName('tw'));
  print(capitalizeName2(null));
  print(capitalizeName2('twwt'));
  print(capitalizeName3(null));
  print(capitalizeName4('tw4'));
  print(capitalizeName4(null));

  String? name;
  name ??= 'twtw';
  name ??= 'another';
  print(name);
}
