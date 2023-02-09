import 'dart:io';

void main(List<String> args) {
  //ip: 192.168.4.60
  //port : 5004
  late List total;

  // final int outputInverval = 50;

  // RawDatagramSocket.bind(InternetAddress.anyIPv4, 5004)
  RawDatagramSocket.bind(InternetAddress('192.168.4.60'), 5004)
      .then((RawDatagramSocket socket) {
    print('Datagram socket ready to receive');
    print('${socket.address.address}:${socket.port}');

    socket.listen((RawSocketEvent e) {
      Datagram? d = socket.receive();
      if (d == null) return;

      //check size & sum datagram
      if (d.data.length == 32752) {
        total = d.data;
      } else if (d.data.length == 26456) {
        if (total.length == 32752) {
          total += d.data;
        }
      }

      // String messgae = new String.fromCharCodes(d.data).trim();
      // print('Datagram from ${d.address.address}:${d.port}: ${messgae}');
      //16진수로 출력
      // var str_hex = d.data.map((e) => e.toRadixString(16));
      // print('Input [${d.data.length}]: $str_hex');

      if (total.length == 32752 + 26456) {
        /*
        var str_hex = total.map((e) => e.toRadixString(16));
        print('Input [${total.length}]: $str_hex');
        */
        /*
        print('Input [${total.length}] : ');
        for (var i = 0; i < total.length; i += outputInverval) {
          late var str;
          if (i + outputInverval > total.length)
            str =
                total.getRange(i, total.length).map((e) => e.toRadixString(16));
          else
            str = total
                .getRange(i, i + outputInverval)
                .map((e) => e.toRadixString(16));
          print(str);
        }*/
        var str = total.map((e) => e.toRadixString(16));
        // var end1=total.length-2;
        // var end2=total.length-1;
        print(
            'Input[${total.length}] [${str.elementAt(0)}][${str.elementAt(1)}]...[${str.elementAt(str.length - 2)}][${str.elementAt(str.length - 1)}]');
      }
    });
  });
}
