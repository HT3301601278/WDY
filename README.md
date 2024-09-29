# 物联网设备管理系统

## 项目简介

这是一个基于Flutter开发的物联网设备管理系统移动应用。该应用允许用户登录、注册、管理物联网设备,并查看设备的数据分析。本项目旨在为物联网设备管理提供一个直观、易用的移动端解决方案。

## 功能特性

1. 用户认证:登录和注册
2. 设备管理:查看、添加设备
3. 设备详情:查看单个设备的详细信息
4. 数据分析:查看设备的数据分析报告

## 技术栈

- Flutter: 跨平台移动应用开发框架
- Dart: 编程语言
- HTTP: 网络请求
- JSON: 数据交换格式
- Material Design: UI设计语言

## 项目结构

```
lib/
├── models/
│   └── device.dart
├── screens/
│   ├── login_register_screen.dart
│   ├── device_management_screen.dart
│   ├── device_detail_screen.dart
│   └── data_analysis_screen.dart
├── services/
│   ├── auth_service.dart
│   └── device_service.dart
├── utils/
│   └── constants.dart
├── widgets/
│   ├── login_form.dart
│   └── register_form.dart
└── main.dart
```

## 详细说明

### 1. 主程序入口 (main.dart)

主程序入口定义了应用的基本主题和路由。


```1:51:lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login_register_screen.dart';
import 'screens/device_management_screen.dart';
import 'utils/constants.dart';
void main() {
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '物联网设备管理',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginRegisterScreen(),
        '/devices': (context) {
          if (ApiConstants.token.isEmpty) {
            return const LoginRegisterScreen();
          }
          return const DeviceManagementScreen();
        },
      },
    );
  }
}
```


这里我们设置了应用的主题颜色、输入框样式和按钮样式,以确保整个应用的一致性。同时,我们也定义了初始路由和其他路由,包括登录/注册页面和设备管理页面。

### 2. 登录和注册页面 (login_register_screen.dart)

这个页面包含了登录和注册功能,用户可以在两者之间切换。

主要组件:
- LoginForm: 登录表单
- RegisterForm: 注册表单

这个页面使用了卡片式设计和渐变背景,提供了良好的视觉体验。

### 3. 设备管理页面 (device_management_screen.dart)

设备管理页面显示了用户所有的设备列表,并提供了添加新设备的功能。


```1:169:lib/screens/device_management_screen.dart
import 'package:flutter/material.dart';
import '../services/device_service.dart';
import '../models/device.dart';
import 'device_detail_screen.dart';
import 'data_analysis_screen.dart';
import 'data_analysis_screen.dart';
class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({Key? key}) : super(key: key);
  const DeviceManagementScreen({Key? key}) : super(key: key);
  @override
  _DeviceManagementScreenState createState() => _DeviceManagementScreenState();
}
}
class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  late Future<List<Device>> _devicesFuture;
  late Future<List<Device>> _devicesFuture;
  @override
  void initState() {
    super.initState();
    _devicesFuture = DeviceService.getAllDevices();
  }
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
                  TextButton(
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
```


这个页面使用了 `FutureBuilder` 来异步加载设备列表,并使用 `ListView.builder` 来高效地显示设备列表。每个设备项都使用了卡片式设计,提供了设备的基本信息。

### 4. 设备详情页面 (device_detail_screen.dart)

设备详情页面显示了单个设备的详细信息。


```1:99:lib/screens/device_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/device.dart';
import 'data_analysis_screen.dart';
class DeviceDetailScreen extends StatefulWidget {
class DeviceDetailScreen extends StatelessWidget {
  final Device device;
  const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);
  const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.deviceName),
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildInfoRow(Icons.devices, '设备ID', '${device.id}'),
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.router, 'MAC地址', device.macAddress),
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.settings_ethernet, '通信通道', device.communicationChannel),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.analytics),
                          label: const Text('查看数据分析'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataAnalysisScreen(device: device),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```


这个页面使用了卡片式设计来展示设备信息,并提供了一个按钮来查看数据分析。

### 5. 数据分析页面 (data_analysis_screen.dart)

数据分析页面显示了设备的数据分析结果。


```1:109:lib/screens/data_analysis_screen.dart
import 'package:flutter/material.dart';
import '../models/device.dart';
import '../services/device_service.dart';

class DataAnalysisScreen extends StatefulWidget {
  final Device device;

  const DataAnalysisScreen({Key? key, required this.device}) : super(key: key);

  @override
  _DataAnalysisScreenState createState() => _DataAnalysisScreenState();
}

class _DataAnalysisScreenState extends State<DataAnalysisScreen> {
  late Future<List<Map<String, dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = DeviceService.getDeviceData(widget.device.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.device.deviceName} 数据分析'),
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('错误: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('没有数据'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '设备数据',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 20,
                                headingRowColor: MaterialStateProperty.all(Colors.blue.shade200),
                                columns: const [
                                  DataColumn(label: Text('序号', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('值', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('时间', style: TextStyle(fontWeight: FontWeight.bold))),
                                ],
                                rows: snapshot.data!.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final data = entry.value;
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (index % 2 == 0) return Colors.grey.shade50;
                                        return null;
                                      },
                                    ),
                                    cells: [
                                      DataCell(Text('${index + 1}')),
                                      DataCell(Text('${data['value']}')),
                                      DataCell(Text('${data['at']}')),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
```


这个页面使用了 `DataTable` 来展示设备数据,提供了清晰的数据展示方式。

### 6. 服务类

- AuthService: 处理用户认证相关的API请求
- DeviceService: 处理设备相关的API请求

这些服务类封装了与后端API的交互,使得数据获取和处理更加简洁和模块化。

## 如何运行项目

1. 确保你已经安装了Flutter开发环境。
2. 克隆本项目到本地。
3. 在项目根目录运行 `flutter pub get` 安装依赖。
4. 连接模拟器或真机设备。
5. 运行 `flutter run` 启动应用。