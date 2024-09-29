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
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade100],
          ),
        ),
        child: FutureBuilder<List<Device>>(
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
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.devices, color: Colors.blue),
                      title: Text(device.deviceName, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(device.macAddress),
                      trailing: Chip(
                        label: Text(device.communicationChannel),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceDetailScreen(device: device),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDeviceDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddDeviceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String deviceName = '';
        String macAddress = '';
        String communicationChannel = '';
        return AlertDialog(
          title: const Text('添加新设备'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: '设备名称',
                    prefixIcon: Icon(Icons.device_unknown),
                  ),
                  onChanged: (value) => deviceName = value,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'MAC地址',
                    prefixIcon: Icon(Icons.router),
                  ),
                  onChanged: (value) => macAddress = value,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: '通信通道',
                    prefixIcon: Icon(Icons.settings_ethernet),
                  ),
                  onChanged: (value) => communicationChannel = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'deviceName': deviceName,
                  'macAddress': macAddress,
                  'communicationChannel': communicationChannel,
                });
              },
              child: const Text('添加'),
            ),
          ],
        );
      },
    ).then((result) async {
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
    });
  }
}