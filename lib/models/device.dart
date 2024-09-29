class Device {
  final int id;
  final String deviceName;
  final String macAddress;
  final String communicationChannel;

  Device({
    required this.id,
    required this.deviceName,
    required this.macAddress,
    required this.communicationChannel,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as int,
      deviceName: json['deviceName'] as String? ?? '',
      macAddress: json['macAddress'] as String? ?? '',
      communicationChannel: json['communicationChannel'] as String? ?? '',
    );
  }
}