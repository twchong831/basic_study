# Flutter

[Source](https://nomadcoders.co/)

## make project

```powershell
# move project directory
cd [dir]
flutter create [project_name]
```

## setting

### user settings in vscode

- 자동으로 const 항목에 const를 추가

```json
// add
"editor.codeActionsOnSave": {
  "source.fixAll": true
 },
//-------
 "dart.openDevTools": "flutter",
 "latex-workshop.view.pdf.viewer": "tab",
 "[latex]": {
  "editor.defaultFormatter": "James-Yu.latex-workshop"
 },
 "[tex]": {
 },
```

- 소스코드 가이드라인 생성

```json
"dart.previewFlutterUiGuides": true,
```

- code Action with VSCode
- 단축키 : [ cmd + . ]

![ex codeaction](./image/img_flutter_codeAction.png)

## FUNC

### how to make widget using vscode

```dart
stl + 자동완선
```

- vscode의 자동완성 기능을 사용하여
- 편리하게 statefulwidget이나 statefulesswidget을 생성할 수 있음

### using Package

#### ex) url_launcher

[참조](https://pub.dev/packages/url_launcher)

##### install

- terminal
  
```powershell
flutter pub add url_launcher
```

- flutter

```dart
// add pubspec.yaml
dependencies:
  url_launcher: ^6.1.9
```

##### configuration

- 설정을 해주어야 하는 패키지가 있음
- ios, 안드로이드 등 운영체제 별로 설정해주어야 함.

- ios : /project/ios/Runner/Base.Iproj/Info.plist에 추가

- 추가 후, 디버깅 중이라면 디버깅을 새로해야함.
