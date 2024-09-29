import 'package:flutter/material.dart';
import '../models/device.dart';
import 'data_analysis_screen.dart';

class DeviceDetailScreen extends StatefulWidget {
  final Device device;

  const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.deviceName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('设备ID: ${widget.device.id}'),
            Text('MAC地址: ${widget.device.macAddress}'),
            Text('通信通道: ${widget.device.communicationChannel}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 导航到数据分析页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataAnalysisScreen(device: widget.device),
                  ),
                );
              },
              child: const Text('查看数据分析'),
            ),
          ],
        ),
      ),
    );
  }
}