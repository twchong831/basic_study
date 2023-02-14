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
