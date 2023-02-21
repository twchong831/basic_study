# flutter network

## example

### macOS only

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

#### result

![결과](./image/img_flutter_network_get_01.png)
