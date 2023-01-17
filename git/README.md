# git 관련 사항 정리

## .DS_Store

- mac os에서 정의한 파일 포맷

```powershell
# remove .DS_Store
find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch

# not upload 
echo .DS_Store >> .gitignore
```
