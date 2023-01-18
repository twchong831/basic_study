# git 관련 사항 정리

## .DS_Store

- mac os에서 정의한 파일 포맷

```powershell
# remove .DS_Store
find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch

# not upload 
echo .DS_Store >> .gitignore
```

## repo

### repo 설정

- default.xml 추가
- 또는 manifest/default.xml을 추가하고 커밋.
- 어느쪽을 참조하는지 아직 모르겠음?

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<manifest>
	<remote name="origin"
	fetch="https://github.com/twchong831/repo_test"/>
	<remote name="ros"
	fetch="https://github.com/twchong831/basic_study/ros"/>
</manifest>
```

### repo 다운로드

```powershell
repo init -u https://github.com/twchong831/repo_test.git
repo sync
```

- 정상동작하는 것으로 보이지만,
- 아직 xml에 선언된 레포지토리를 가져오지 않음...
