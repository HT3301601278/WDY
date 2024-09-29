# 物联网设备管理系统

## 项目简介

物联网设备管理系统是一个基于Flutter开发的跨平台移动应用，旨在帮助用户轻松管理和监控其物联网（IoT）设备。通过直观的用户界面，用户可以注册和登录账户、查看设备列表、管理设备详情以及分析设备产生的数据。本项目适合希望学习Flutter应用开发及物联网设备管理的初学者和开发者。

## 功能特性

1. **用户认证**
   - 用户注册与登录
   - 表单验证与错误处理

2. **设备管理**
   - 查看所有已注册的设备
   - 添加新设备
   - 查看设备详情
   - 删除或编辑设备信息

3. **数据分析**
   - 查看设备产生的数据
   - 数据表格展示
   - 支持数据的排序与筛选

4. **用户界面**
   - 现代化设计与一致的风格
   - 渐变背景与卡片式布局
   - 响应式设计，适配不同屏幕尺寸

## 技术栈

- [Flutter](https://flutter.dev/) - 用于构建跨平台移动应用
- [Dart](https://dart.dev/) - Flutter的编程语言
- [HTTP](https://pub.dev/packages/http) - 处理网络请求
- [JSON](https://dart.dev/guides/json) - 数据交换格式
- [Material Design](https://material.io/design) - UI设计语言

## 安装与运行

### 前提条件

- **Flutter SDK**: 确保已安装Flutter SDK。安装指南见[官方文档](https://flutter.dev/docs/get-started/install)。
- **开发工具**: 推荐使用[Android Studio](https://developer.android.com/studio)或[Visual Studio Code](https://code.visualstudio.com/)。
- **设备或模拟器**: 配置Android或iOS设备，或使用模拟器/仿真器。
- **后端API**: 确保有可用的后端API端点，用于用户认证和设备管理。

### 安装步骤

1. **克隆仓库**

   ```bash
   git clone https://github.com/HT3301601278/WDY.git
   cd 物联网设备管理系统
   ```

2. **安装依赖**

   ```bash
   flutter pub get
   ```

3. **配置API常量**

   在 `lib/utils/constants.dart` 文件中，配置API的 `baseUrl` 和 `token`。

   ```dart
   class ApiConstants {
     static const String baseUrl = 'https://api.example.com'; // 替换为您的API端点
     static String token = ''; // 用户登录后设置
   }
   ```

4. **运行应用**

   连接设备或启动模拟器，然后运行：

   ```bash
   flutter run
   ```

## 项目结构

```
lib/
├── main.dart
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
└── widgets/
    ├── login_form.dart
    └── register_form.dart
```

- **main.dart**: 应用入口，配置路由与主题。
- **models/**: 数据模型，如 `Device`。
- **screens/**: 各个页面的实现，包括登录、设备管理、设备详情和数据分析。
- **services/**: 与后端API交互的服务类。
- **utils/**: 常量与工具类。
- **widgets/**: 可复用的组件，如登录和注册表单。

## 详细说明

### 1. 主程序入口 (`main.dart`)

主程序入口定义了应用的基本主题和路由。

```dart
import 'package:flutter/material.dart';
import 'screens/login_register_screen.dart';
import 'screens/device_management_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.symmetric(vertical: 12),
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

**说明:**

- **主题配置**: 设置应用的主色调、输入框样式和按钮样式，确保整个应用的一致性。
- **路由配置**:
  - **初始路由**: `/` 对应 `LoginRegisterScreen` 登录/注册页面。
  - **设备管理路由**: `/devices` 对应 `DeviceManagementScreen` 设备管理页面，如果用户未登录（`token` 为空），则重定向到登录页面。

### 2. 登录和注册页面 (`login_register_screen.dart`)

该页面包含了登录和注册功能，用户可以在两者之间切换。

**主要组件:**

- **LoginForm**: 登录表单
- **RegisterForm**: 注册表单

**样式特点:**

- 使用卡片式设计和渐变背景，提供良好的视觉体验。
- 表单验证与错误处理，确保用户输入的有效性。

```dart
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool _isLogin = true;

  void _toggleView() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isLogin ? '登录' : '注册',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 32),
                      _isLogin ? const LoginForm() : const RegisterForm(),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _toggleView,
                        child: Text(_isLogin ? '没有账号? 注册' : '已有账号? 登录'),
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
}
```

### 3. 设备管理页面 (`device_management_screen.dart`)

设备管理页面显示了用户所有的设备列表，并提供了添加新设备的功能。

**主要功能:**

- **查看设备列表**: 以卡片形式展示设备名称、MAC地址和通信通道。
- **添加新设备**: 通过弹出对话框输入设备信息。
- **查看设备详情**: 点击设备卡片进入设备详细信息页面。

```dart
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
                      title: Text(device.deviceName, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                    prefixIcon: const Icon(Icons.device_unknown),
                  ),
                  onChanged: (value) => deviceName = value,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'MAC地址',
                    prefixIcon: const Icon(Icons.router),
                  ),
                  onChanged: (value) => macAddress = value,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: '通信通道',
                    prefixIcon: const Icon(Icons.settings_ethernet),
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

### 4. 设备详情页面 (`device_detail_screen.dart`)

设备详情页面展示单个设备的详细信息，并提供查看数据分析的功能。

**主要功能:**

- **查看设备信息**: 包括设备ID、MAC地址和通信通道。
- **查看数据分析**: 导航到数据分析页面，查看设备产生的数据。

**样式特点:**

- 使用卡片式布局和渐变背景，保持与其他页面的一致性。
- 使用图标增强信息展示。

```dart
import 'package:flutter/material.dart';
import '../models/device.dart';
import 'data_analysis_screen.dart';

class DeviceDetailScreen extends StatelessWidget {
  final Device device;

  const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);

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

### 5. 数据分析页面 (`data_analysis_screen.dart`)

数据分析页面展示设备产生的数据，使用 `DataTable` 进行清晰的数据展示。

**主要功能:**

- **查看设备数据**: 包括序号、值和时间。
- **数据表格展示**: 支持水平和垂直滚动，适配不同数据量。

**样式特点:**

- 使用卡片式布局和渐变背景，保持与其他页面的一致性。
- 表格行采用交替颜色，增强可读性。

```dart
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
  }
}
```

### 6. 服务类

**1. AuthService (`auth_service.dart`)**

处理用户认证相关的API请求，包括登录和注册。

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';

class AuthService {
  static Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ApiConstants.token = json['token'];
      return User.fromJson(json);
    } else {
      throw Exception('登录失败');
    }
  }

  static Future<User> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('注册失败');
    }
  }
}
```

**2. DeviceService (`device_service.dart`)**

处理设备相关的API请求，包括获取所有设备和注册新设备。

```dart
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
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Device.fromJson(json)).toList();
    } else {
      throw Exception('获取设备列表失败');
    }
  }

  static Future<Device> registerDevice(String deviceName, String macAddress, String communicationChannel) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/devices'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
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

  static Future<List<Map<String, dynamic>>> getDeviceData(String deviceId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/devices/$deviceId/data'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${ApiConstants.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('获取设备数据失败');
    }
  }
}
```

### 7. 数据模型

**Device 模型 (`device.dart`)**

定义设备的数据结构。

```dart
class Device {
  final String id;
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
      id: json['id'],
      deviceName: json['deviceName'],
      macAddress: json['macAddress'],
      communicationChannel: json['communicationChannel'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'deviceName': deviceName,
        'macAddress': macAddress,
        'communicationChannel': communicationChannel,
      };
}
```

**User 模型 (`user.dart`)**

定义用户的数据结构。

```dart
class User {
  final String id;
  final String username;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'token': token,
      };
}
```

### 8. 工具类

**常量文件 (`constants.dart`)**

存储应用中使用的常量，如API端点和用户Token。

```dart
class ApiConstants {
  static const String baseUrl = 'https://api.example.com'; // 替换为您的API端点
  static String token = ''; // 用户登录后设置
}
```

### 9. 小部件

**登录表单 (`login_form.dart`)**

实现用户登录表单。

```dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: '用户名',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入用户名';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: '密码',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await AuthService.login(
                    _usernameController.text,
                    _passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/devices');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('登录'),
          ),
        ],
      ),
    );
  }
}
```

**注册表单 (`register_form.dart`)**

实现用户注册表单。

```dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: '用户名',
              prefixIcon: const Icon(Icons.person_add),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入用户名';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: '密码',
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              if (value.length < 6) {
                return '密码长度至少为6位';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await AuthService.register(
                    _usernameController.text,
                    _passwordController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('注册成功,请登录')),
                  );
                  setState(() {
                    // 切换到登录视图
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('注册失败: $e')),
                  );
                }
              }
            },
            child: const Text('注册'),
          ),
        ],
      ),
    );
  }
}
```

## 使用指南

### 用户认证

1. **注册账户**
   - 打开应用，点击“没有账号? 注册”按钮。
   - 输入用户名和密码，点击“注册”按钮。
   - 注册成功后，会提示“注册成功,请登录”。

2. **登录**
   - 输入已注册的用户名和密码，点击“登录”按钮。
   - 登录成功后，会导航到设备管理页面。

### 设备管理

1. **查看设备列表**
   - 登录后，进入设备管理页面，可查看所有已注册的设备。
   - 每个设备以卡片形式展示，显示设备名称、MAC地址和通信通道。

2. **添加新设备**
   - 点击右下角的“+”按钮，弹出添加设备对话框。
   - 输入设备名称、MAC地址和通信通道，点击“添加”。
   - 添加成功后，设备会出现在列表中。

3. **查看设备详情**
   - 点击设备卡片，进入设备详情页面。
   - 查看设备的ID、MAC地址和通信通道。
   - 点击“查看数据分析”按钮，进入数据分析页面。

### 数据分析

1. **查看数据**
   - 在设备详情页面，点击“查看数据分析”按钮。
   - 数据分析页面展示设备产生的数据，包括序号、值和时间。
   - 数据以表格形式展示，支持滚动查看。

---