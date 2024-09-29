import 'package:flutter/material.dart';
import '../services/device_service.dart';
import '../models/device.dart';
import 'device_detail_screen.dart';
import 'data_analysis_screen.dart';

class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({Key? key}) : super(key: key);

  @override
  _DeviceManagementScreenState createState() => _DeviceManagementScreenState();
}

class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  late Future<List<Device>> _devicesFuture;

  @override
  void initState() {
    super.initState();
    _devicesFuture = DeviceService.getAllDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设备管理'),
      ),
      body: FutureBuilder<List<Device>>(
        future: _devicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('错误: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('没有设备'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final device = snapshot.data![index];
                return ListTile(
                  title: Text(device.deviceName, style: TextStyle(fontFamily: 'Roboto')),
                  subtitle: Text(device.macAddress, style: TextStyle(fontFamily: 'Roboto')),
                  trailing: Text(device.communicationChannel, style: TextStyle(fontFamily: 'Roboto')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeviceDetailScreen(device: device),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (BuildContext context) {
              String deviceName = '';
              String macAddress = '';
              String communicationChannel = '';
              return AlertDialog(
                title: const Text('添加新设备'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: '设备名称'),
                      onChanged: (value) => deviceName = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'MAC地址'),
                      onChanged: (value) => macAddress = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: '通信通道'),
                      onChanged: (value) => communicationChannel = value,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('取消'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop({
                      'deviceName': deviceName,
                      'macAddress': macAddress,
                      'communicationChannel': communicationChannel,
                    }),
                    child: const Text('添加'),
                  ),
                ],
              );
            },
          );

          if (result != null) {
            try {
              final newDevice = await DeviceService.registerDevice(
                result['deviceName']!,
                result['macAddress']!,
                result['communicationChannel']!,
              );
              setState(() {
                _devicesFuture = DeviceService.getAllDevices();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('设备 ${newDevice.deviceName} 添加成功')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('添加设备失败: $e')),
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}