import 'dart:ffi';

void typeChecker(var type) {
  if (type is String) {
    print('TYPE is String : $type');
    // type.isEmpty;
  } else if (type is int) {
    print('TYPE is int : $type');
    // type.isEven;
    // type.isOdd;
    // type.isInfinite;
  } else if (type is bool) {
    print('TYPE is bool : $type');
    // type.hashCode;
  } else if (type is double) {
    print('TYPE is double : $type');
    // type.isInfinite;
    // type.isNaN;
  } else if (type is Float) {
    print('TYPE is Float : $type');
    // type.hashCode;
  }
}

bool checkEmpty(String string) {
  if (string.length == 0)
    return false;
  else
    return true;
}

void main() {
  // hello world
  print('hello dart world');

  // var.
  var name = 'taewon-1'; // auto variable settings
  String name2 = 'taewon-2'; // String type

  // dynamic type
  var name3; // is defined dynamic type

  name3 = 1;
  typeChecker(name3);
  name3 = 'name?';
  typeChecker(name3);
  name3 = true;
  typeChecker(name3);

  // NULL safety
  String? name4 = 'taewon'; //nullale하게하려면 ?을 추가
  name4 = null;
  // checkEmpty(name4);
  if (name4 != null) {
    name4.isNotEmpty;
  }
  name4?.isNotEmpty;

  // final Var. -- 12/31
  var ty_var = 'tw';
  String ty_var_st = 'tw_str';
  // ty_var = 1; // it's error.

  final ty_var_final = 'twtw';
  // ty_var_final = 'chong'; //error only define one time...

  // late Var. -- 12/31
  /*
   late final var ty;
   late var ty;
  */
  late final String ty_late_f;
  // do somethings...
  // ....
  // do somethings END..
  ty_late_f = 'twtw'; //if using late, can define Var. later, only once.

  // constant Var. -- 12/31
  const ty_const = 'twtw';
  /*
    final과 유사하지만, 
    const type은 compile-time에 값을 알고있어야 함
    사용자로부터 입력받거나, api로부터 값을 받는 경우에는 final로 선언할 필요가 있음
  */
}
