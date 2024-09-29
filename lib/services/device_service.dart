import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/device.dart';
import '../utils/constants.dart';

class DeviceService {
  static Future<List<Device>> getAllDevices() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/devices'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${ApiConstants.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => Device.fromJson(json)).toList();
    } else {
      throw Exception('获取设备列表失败');
    }
  }

  static Future<List<Map<String, dynamic>>> getDeviceData(int deviceId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/devices/$deviceId/data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.token}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['datapoints']);
    } else {
      throw Exception('获取设备数据失败');
    }
  }

  static Future<Device> registerDevice(String deviceName, String macAddress, String communicationChannel) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/devices/register'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.token}',
      },
      body: jsonEncode({
        'deviceName': deviceName,
        'macAddress': macAddress,
        'communicationChannel': communicationChannel,
      }),
    );

    if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('注册设备失败');
    }
  }
}