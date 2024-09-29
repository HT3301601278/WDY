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