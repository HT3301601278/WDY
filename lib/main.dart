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