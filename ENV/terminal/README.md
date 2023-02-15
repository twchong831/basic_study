# Termianl Settings

## UBUNTU

## MAC

### brew

[홈페이지](https://brew.sh/index_ko)

- 패키지 관리 툴 설치

```powershell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### iterm2

[참조](https://danaing.github.io/etc/2022/03/28/M1-mac-iTerm2-setting.html)

```powershell
brew install iterm2
```

### Oh-my-zsh

[홈페이지](https://ohmyz.sh/#install)
[참조](https://danaing.github.io/etc/2022/03/28/M1-mac-iTerm2-setting.html)

- 터미널 툴을 변경

```powershell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### autoComplete

```powershell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### Syntax Highlight

```powershell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### my zshrc setting

```powershell
# vim ~/.zshrc

plugins=(
    #other plugin
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```

### fig

[홈페이지](https://fig.io/)

- 커맨드 라인 툴
- 자동 완성등을 지원

```powershell
# install
brew install fig

# login
fig login    # using github or email

# check fig
fig doctor    

# restart
fig restart
```

#### ERROR

1. path of ( ~/.bashrc )

   ```powershell
    fig doctor
    fig restart
    ```

2. path of ( ~/.local/bin )

    ```powershell
    sudo chown -R $(id -un) ~/.local
    fig doctor
    fig restart
    ```

    - 안된다면 터미널을 재실행
