# git 관련 사항 정리

## commit message convention

### type

- feat : 새로운 기능 추가
- fix : 버그 수정
- docs : 문서 수정
- style : 코드 포맷팅, 코드 변경이 없는 경우
- refactor : 코드 리펙토링
- test : 테스트 코드
- chore : 빌드 업무 수정

## .DS_Store

- mac os에서 정의한 파일 포맷

```powershell
# remove .DS_Store
find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch

# not upload 
echo .DS_Store >> .gitignore
```

## REPO

### repo 생성

- default.xml 추가

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<manifest>
    <remote name="basic"
    fetch="https://github.com/twchong831"/>
    <!-- name : repo manifest에서 참조하는 레포지토리의 이름 -->
    <!-- fetch : 원본이 되는 레포지토리의 경로 -->

    <default revision="main"
    remote="basic"
    sync-j="2"
    sync-c="true"/>
    <!-- revision : 가져올 레포지토리의 branch 명? -->

    <!--for dmt-->
    <project path="test/twchong" name="twchong831.git" remote="basic"/>
    <project path="base_study" name="basic_study.git" remote="basic"/>
    <!-- path : repo 다운로드 시 해당 레포지토리의 위치 설정 -->
    <!-- name : 가져올 레포지토리의 이름 -->
    <!-- remote : 참조하는 원본 경로? -->
</manifest>
```

### 브랜치명이 서로 다른 경우

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<manifest>
    <remote name="basic"
    fetch="https://github.com/twchong831"/>

    <!--for dmt-->
    <project path="test/twchong" name="twchong831.git" remote="basic" revision="main"/>
    <project path="base_study" name="basic_study.git" remote="basic" revision="main"/>
    <project path="lidar" name="LiDAR.git" remote="basic" revision="test"/>
</manifest>
```

### repo 다운로드

```powershell
repo init -u https://github.com/twchong831/repo_test.git
repo sync
```

- repo가 다운로드되는 것을 확인

## ssh 관련

### ssh-keygen

```powershell
ssh-keygen    # generate ssh key
ssh-copy-id -i ~/.ssh/id_rsa.pub [id]@[ip address]    # ssh key copy in git server
```

### ssh-config

```powershell
# ~/.ssh/config
Host [usedLocal_hostName]
    User [user.name]
    HostName [ip address]
    Port [port number]
    IdentityFile ~/.ssh/id_rsa # if using ssh-key

# used ssh config when ssh
ssh [usedLocal_hostName]
```

#### mac

- mac OS에서는 간혹 ssh-keygen 시, 비밀번호가 할당되는 경우가 있음
- ssh나 git 사용 시, 비밀번호를 입력하지 않으면, key가 동작하지 않음
- 이를 위해 config 파일에 다음 옵션을 추가

```powershell
Host [usedLocal_hostName]
    UseKeychain yes    # add for password
    User [user.name]
    HostName [ip address]
    Port [port number]
    IdentityFile ~/.ssh/id_rsa # if using ssh-key
```

- 위와 같이 config 파일 수정 후,
- 한번 ssh나 git을 실행하고 비밀번호를 입력하면
- 이후 ssh-key 관련 비밀번호 입력이 생략됨.
