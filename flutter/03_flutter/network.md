# flutter network

## example

### NetworkInterface

#### macOS only

```dart
  void getNetworkInform() async {
    print("pushed [getNetworkInform] ${NetworkInterface.list()}");

    for (var ifc in await NetworkInterface.list()) {
      print('== Interface : ${ifc.name} ==');
      for (var addr in ifc.addresses) {
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }
```

##### result

![결과](./image/img_flutter_network_get_01.png)

### r_get_ip

[ref.](https://pub.dev/packages/r_get_ip)

## Error

### operation not permitted

#### mac OS

- add config text in files

```powershell
/flutter-project/macos/Runner/DebugProfile.entitlements
and
/flutter-project/macos/Runner/Release.entitlements
```

```json
 <key>com.apple.security.network.client</key>
 <true/>
```
