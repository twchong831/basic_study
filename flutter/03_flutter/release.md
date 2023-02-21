# flutter release

## release

```powershell
cd project_dir/web
cd ../build/web    # make build web
```

## web

### using Github

- github에 배포를 위한 새로운 repository 생성
- 이 때, repository는 다음과 같은 규칙을 준수해야함
- **[user.name]/[user.name].github.io**
- 위와 같이 선언한 repository를 컴퓨터로 clone
- flutter 프로젝트 디렉토리에서 build/web 디렉토리를
- clone한 repository로 복사

- index.html 파일을 수정
- <base href="/">를 web 경로로 수정

```html
<!DOCTYPE html>
<html>
<head>
  <!--
    If you are serving your web app in a path other than the root, change the
    href value below to reflect the base path you are serving from.

    The path provided below has to start and end with a slash "/" in order for
    it to work correctly.

    For more details:
    * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base

    This is a placeholder for base href that will be replaced by the value of
    the `--base-href` argument provided to `flutter build`.
  -->
  <!-- <base href="/"> -->
  <base href="./web/">

  <meta charset="UTF-8">
```

#### 접속

- [ https://[user.name]/.github.io/web ]으로 접속 가능

<https://twchong831.github.io/network_app/#/>
