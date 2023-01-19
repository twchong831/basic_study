# git 관련 사항 정리

## .DS_Store

- mac os에서 정의한 파일 포맷

```powershell
# remove .DS_Store
find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch

# not upload 
echo .DS_Store >> .gitignore
```

# REPO

## repo 생성

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

## repo 다운로드

```powershell
repo init -u https://github.com/twchong831/repo_test.git
repo sync
```

- repo가 다운로드되는 것을 확인
