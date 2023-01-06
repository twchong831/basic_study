# Study DART

## 2022-12-28

다트의 기초

- 두 개의 컴파일러를 통해 OS에 맞게 컴파일됨
  - Dart web : drat -> javascript
  - Dart Native : 그 외 OS의 app으로 컴파일

### dart 개발환경 구축

- VSCODE의 flutter extension 이용
  - https://docs.flutter.dev/get-started/install/macos
  - 참조하여 개발환경 세팅 필요
- 또는 https://dartpad.dev/? 웹사이트를 이용한 코딩 가능

## Variable

### type

```flutter
void main(){
    var name = 'tw';
    String name1 = 'tw';
}
```

- 일반적으로 var 변수명을 사용하면, 입력한 값에 따라 자동적으로 변구 타입을 지정해 줌.
- String, int, double, float, bool 등 일반 변수 타입도 사용 가능

### dynamic Type

```flutter
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

void main(){
    var name;
    name = 'tw';
    typeChecker(name);
    name = 1;
    typeChecker(name);
    name = true;
    typeChecker(name);
}
```

- 별도의 선언 없이 var만 선언할 경우
- var은 dynamic 타입을 가지게 됨.
- 입력되는 값의 타입에 따라 선언한 변수의 타입이 변경됨

#### NULL safety

```flutter
void main(){
    String? name = 'tw';
    name = null;
    if(name != null){
        if(name.isNotEmpty){
            // do something
        }
    }
    //or
    name?.isNotEmpty;
}
```

- 변수의 null 값에 의한 오류를 방지하기 위한 기능.
- 일반적으로 null 값이 있는 변수가 있을 경우 컴파일 에러가 발생하며,
- 특정 변수에 null 값을 입력하거나 사용하고자 할 경우 변수 선언 시, ?을 추가하여 선언할 필요가 있음.

#### final type

```flutter
void main(){
    var name = 'tw';
    // name = 1;     // ERROR
    // 선언 시, String 타입의 값을 입력하면서 고정되었기 때문에
    // 1 값을 입력하면, 타입 오류게 의한 에러가 발생함.
    
    final name2 = 'twtw';
    // name2 = 'tw2';    //ERROR
}
```

- 일반적으로 변수 선언 시, 변수 값을 입력하게 되면,
- 해당 변수의 타입은 고정되게 됨.

- final 타입은 선언 시, 한 번만 변수의 값을 입력할 수 있도록 선언하는 타입
- 이후 변수값을 변경하고자 할 경우 에러를 출력하게 됨.

#### late type

```flutter
void main(){
    late final String name;
    // do somethings...
    // do somethings END...
    name = 'twtw';
}
```

- 일반적으로 final 타입과 같이 사용하는 타입
- final 타입은 한 번만 변수의 값을 입력할 수 있는데,
- late 선언을 추가함으로서, 변수 선언 이후에 한 번만 변수 값을 입력할 수 있음

#### const type

```flutter
void main(){
    const name = 'tw';
    const nam2 = someAPI_VALUE();    // ERROR
}
```

- final 타입과 유사하지만,
- const 타입은 complie 시, 해당 값이 특정 값을 가지고 있어야 함.
- 위 코드와 같이 어떠한 API로부터 값을 받을 경우에는 에러가 발생
- 사용자로부터 입력받거나, api로부터 값을 받을 경우에는 final 타입으로 선언할 필요가 있음.
