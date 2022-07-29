# How to check ethernet Port Using Shell script

## check ethernet port
```powershell
sudo ethtool [port name]
```
```powershell
# sudo ethtool [port name] result
Settings for docker0:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: no
```
* 위와 같은 툴을 통해 ethernet port의 연결을 확인할 수 있음
* Link detected를 확인하고 yes/no 인지 확인하여 ethernet port가 연결 상태인지 확인할 수 있음

### link detected 확인
```powershell
$(sudo ethtool ${name} | grep detected)
# result
        Link detected: no
```
* ethtool의 결과 중 detected 부분만을 추출

```powershell
	str=$(sudo ethtool ${name} | grep detected)
	state_=$(echo ${str} | cut -d ':' -f2)	# check ethernet port status
```
* ethtool의 결과 중 detected를 추출하고 
* 그 중에서 Link detected:를 제거

