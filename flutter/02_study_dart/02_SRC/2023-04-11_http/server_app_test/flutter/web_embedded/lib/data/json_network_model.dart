class JsonNetworkModel {
  final String name;
  final String ip;
  final String _netmask;
  final String _gateway;

  static String _convertIP2gateway(String ip) {
    List<String> ips = ip.split('.');
    return '${ips[0]}.${ips[1]}.${ips[2]}.1';
  }

  JsonNetworkModel({
    required this.name,
    required this.ip,
    String? netmask,
    String? gateway,
  })  : _netmask = netmask ?? "255.255.255.0",
        _gateway = gateway ?? _convertIP2gateway(ip);

  JsonNetworkModel.fromJson(Map<String, dynamic> jsonType)
      : name = jsonType['name'],
        ip = jsonType['ip'],
        _netmask = jsonType['netmask'] ?? '255.255.255.0',
        _gateway = jsonType['gateway'] ?? _convertIP2gateway(jsonType['ip']);
}
