# VSCODE

- Visual Studio Code를 이용한 원격 개발 환경 구축

## 설치 플러그인

![remote-ssh](image\remote-ssh.PNG)

![remote-development](image\remote-development.PNG)

- remote를 위한 확장 플러그인을 설치
  - Remote - SSH
  - Remote Development
  - VSCode Terminal For Ubuntu

## SSH 설정

![ssh config 01](image\remote_ssh_connect2host.png)

- [F1] 키를 이용하여 커맨드 창을 엶
- Remote-SSH: Connect to Host... 검색

![ssh config 02](image\remote_ssh_connect2host_02.png)

- [ubuntu_user]@[IP] -> ex) root@192.168.100.60
- 위와 같이 타겟의 사용자명과 IP를 설정

![ssh config 03](image\remote_ssh_connect2host_pwd.png)

- 설정이 올바르다면 그림과 같이 비밀번호를 입력하라는 창이 출력됨.
- 타겟의 로그인 비밀번호를 입력

![ssh config 04](image\remote_ssh_connect2host_check.png)

- VSCODE의 터미널 창을 열어서 확인해보면
- 그림과 같이 타겟과 연결된 것을 확인할 수 있으며,
- 또는 하단부 상에서 SSH: [IP]:[PORT] 출력을 통해 원격 접속 결과를 확인할 수 있음

### 설정 저장

- 자주 접속하는 타겟의 정보를 저장하는 방법

![ssh config save](image\make_config.png)

- [F1] 키를 이용하여 커맨드 창을 엶
- Remote-SSH: Open SSH Configuration File...

![ssh config save 02](image\make_config_02.PNG)

- config 파일을 선택
- 일반적으로 C:\user\사용자명 \ .ssh\config

![ssh config save 03](image\make_config_03.PNG)

- config 파일에 위 그림과 같이 입력
- 이후에는 이를 그림과 같이 SSH target 항목에서 직접 찾을 수 있음

## 폴더 열기

- 원격 접속된 타겟으로부터 파일을 열기

![open folder 01](image\ssh_open_folder.PNG)

- ssh 접속이 되어 있는 상태에서 [폴더 열기]를 선택

![open folder 02](image\ssh_open_folder_02.PNG)

- [폴더 열기]를 누르게 되면 그림과 같이 열 경로를 선택하게 됨
- 알맞은 경로를 입력하고 엶

![open folder 03](image\ssh_open_folder_03.PNG)

- 그림과 같이 선택한 경로의 폴더를 확인할 수 있으며
- 경로 내의 파일을 열어서 편집할 수 있음을 확인할 수 있음
- UI 하단부는 터미널로 사용 가능

## 시리얼 연결

- 윈도우 환경에서 WSL와 serial port를 이용하여 보드와 통신

### 윈도우 우분투 설치 & 설정

![설치](image\w_ubuntu\install_ubuntu.PNG)

- 윈도우 환경에서 WSL과 같은 리눅스 동작을 위한 환경을 제공 중
- 그 중에서 Mircosoft store에서 Ubuntu 버전을 설치
- Serial port 통신이 안되는 경우가 많아 해당 버전으로 설치할 필요가 있음

![실행](image\w_ubuntu\ubuntu_active.PNG)

- 프로그램을 동작시키면 다음과 같이 출력됨.
- 이를 사용하기 위해 update 및 upgrade 수행
- 이후 minicom 설치

```powershell
sudo apt-get install update
sudo apt-get install upgrade
sudo apt-get install minicom -y
```

- 시리얼 포트의 연결 번호 확인
  - 윈도우 상에서 시리얼 포트의 연결 번호를 확인
  - COM[번호]
  - 해당 번호와 동일한 번호를 가지고 Ubuntu에서
  - ttyS[번호]로 할당됨
- 권한 변경

```powershell
sudo chmod 666 /dev/ttyS번호
```

- 위 코드와 같이 해당 tty에 권한을 부여
- minicom 설정 변경

```powershell
sudo minicom -s
```

![set minicom](image\w_ubuntu\set_minicom_01.PNG)

- Serial port setup 항목으로 설정

![set 02](image\w_ubuntu\set_minicom_02.PNG)

- [A]를 눌러 Serial Device를 설정한 tty로 변경
- [F]를 눌러 Hardware Flow Control를 No로 변경
  - 이는 환경마다 다를수 있음
- 그외 baudarte 등을 변경
- 변경할 때는 [enter] 키를 이용

- configuration 항목으로 나와서
- Save setup as dfl... 항목을 통해 현재 세팅을 디폴트 세팅으로 변경할 수 있음

```powershell
sudo minicom

sudo minicom -D /dev/tty[번호]
```

- 디폴트 설정을 사용한다면 sudo minicom만으로 시리얼 통신을 수행할 수 있음

![minicom 동작](image\w_ubuntu\set_minicom_03.PNG)

### VSCode 연동

- vscode와 WSL ubuntu를 연결하기 위해
- VSCode Terminal For Ubuntu라는 플러그인을 설치

![vscode 터미널](image\w_ubuntu\vscode_connect.png)

- 일반적으로 그림과 같이 터미널 동작 시 동작시킬 터미널을 선택하여 동작시킬수 있음
- VSCode Terminal For Ubuntu 플러그인을 통해 단축키를 통해 간편히 동작시킬 수 있음
- 해당 플러그인이 지원하는 ubuntu가 현재 사용하는 버전

```powershell
[crtl] + [alt] + u
```

![vscode 터미널 연결](image\w_ubuntu\vscode_connect_02.png)

- 단축키를 통해 ubuntu를 연결하고 VScode의 터미널 창에서 출력되는 것을 확인할 수 있음

![vscode minicom 동작](image\w_ubuntu\set_minicom_04.PNG)

- minicom도 정상동작하는 것을 확인할 수 있음

## SH 폴더 이동 세팅

- 한들 등으로 인해 workspace로 이동이 번거로워 sh를 이용한 이동 구현

```sh
#! /bin/bash

cd /mnt/e/{이동 폴더명}
```

- 위와 같이 sh를 구현

```powershell
chmod 777 [파일명.sh]
```

- sh 파일에 권한 부여

```powershell
. [파일명.sh]
```

- 일반적으로 ./ 명령어를 통해 sh를 구동하게 되면
- 폴더 이동이 실행되지 않음
- 위 코드와 같이 . 명령어를 통해 동작시키게 되면
- 폴더 이동이 가능한 것을 확인할 수 있음

## WSL 원격 연결

- 기존 방법으로 단순히 터미널 사용이 가능했지만,
- VSCode를 이용하여 WSL 내의 파일에 좀더 쉽게 접근 가능하도록 구현
- Remote-WSL 플러그 인 설치

![wsl remote](image\w_ubuntu\remote_wsl_ubuntu_01.PNG)

- WSL 연결

![wsl 연결](image\w_ubuntu\remote_wsl_ubuntu_02.PNG)

- 하나의 WSL만 있다면, Remote-WSL: New WSL Window로 바로 실행할 수 있음
- WSL이 두 개 이상 설치되어 있고, 선택해서 실행하고자 한다면,
- Remote-WSL: Open Folder in WSL... 실행

![wsl 선책](image\w_ubuntu\remote_wsl_ubuntu_03.PNG)

- 해당 폴더 중 알맞은 폴더로 이동
- 이후home 폴더까지 이동하여 [폴더 선택]

![wsl 구동](image\w_ubuntu\remote_wsl_ubuntu_04.PNG)

- VSCode 상에서 WSL Ubuntu의 폴더 및 파일을 직접 확인할 수 있음

## WSL 버전 변경

- WSL은 1과 2버전이 존재

![wsl 차이](image\w_ubuntu\diff_WSL.PNG)

- 2 버전이 속도 등에서 이득을 보긴하지만,
- 현재 serial port를 지원하지 않는 문제가 있음
- 보드와의 serial 통신을 위해서 1버전을 사용

### WSL 버전 변경 방법

- 윈도우 cmd 창 구동

![wsl 변경](image\w_ubuntu\change_ver_01.PNG)

```powershell
wsl --l --v
```

- 위 명령어를 통해 현재 설치된 WSL을 확인할 수 있음
- 현재 Ubuntu의 버전이 1인 것을 확인할 수 있음

```powershell
wsl --set-version [WSL 이름] [ver]
# ex) wsl --set-version Ubuntu-18.04 2
```

- 해당 명령어를 통해 WSL의 버전을 변경할 수 있음

![wsl 변경 실행](image\w_ubuntu\change_ver_02.PNG)

- WSL 버전 변경 명령어를 실행하게 되면 버전 변경을 실행하게 됨

![wsl 변경 완료](image\w_ubuntu\change_ver_03.PNG)

- WSL의 버전이 변경된 것을 확인할 수 있음

## debug 세팅

### tasks.json

```json
{
    "tasks": [
		{
			"type": "cppbuild",
			"label": "C/C++: g++ 활성 파일 빌드",
			"command": "/usr/bin/g++",
			"args": [
				"-g",
				"-std=c++11",
				"${file}",
				"-o",
				"${fileDirname}/${fileBasenameNoExtension}",
				"-I/usr/local/bin/",						//경로 추가
                "-L/usr/local/lib/",						//라이브러리 추가
				"-lopencv_core",
				"-lopencv_highgui",
				"-lopencv_imgproc"
			],
			"options": {
				"cwd": "${fileDirname}"
			},
			"problemMatcher": [
				"$gcc"
			],
			"group": {
				"kind": "build",
				"isDefault": true
			},
			"detail": "디버거에서 생성된 작업입니다."
		}
	],
    "version": "2.0.0"
}
```



### launch.json

```json
```

### c_cpp_properties.json

```json
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "/usr/local/lib/**",			//경로 추가
                "/usr/local/bin/**",
                "/usr/local/include/**",
                "/usr/local/include/opencv/",
                "/usr/local/include/opencv2/",
                "/usr/lib/CARNAVICOM/**"
            ],
            "defines": [
                "$(pkg-config",
                "--libs",
                "--cflags",
                "opencv)"
            ],
            "compilerPath": "/usr/bin/g++",
            "cStandard": "gnu17",
            "cppStandard": "gnu++14",
            "intelliSenseMode": "linux-gcc-x64",
            "configurationProvider": "ms-vscode.makefile-tools",
            "compilerArgs": []
        }
    ],
    "version": 4
}
```
