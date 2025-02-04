import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pasarela_app/api/admin_service.dart';

class ReportAdminScreen extends StatefulWidget {
  const ReportAdminScreen({super.key});

  @override
  ReportAdminScreenState createState() => ReportAdminScreenState();
}

class ReportAdminScreenState extends State<ReportAdminScreen> {
  final AdminService _adminService = AdminService();
  bool _isLoading = true;
  int approvedCount = 0;
  int pendingCount = 0;
  int failureCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
    final transactions = await _adminService.getTransactions();

    if (!mounted) return;

    setState(() {
      approvedCount =
          transactions.where((t) => t['status'] == 'approved').length;
      pendingCount = transactions.where((t) => t['status'] == 'pending').length;
      failureCount = transactions.where((t) => t['status'] == 'failure').length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reporte de Transacciones")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Estado de Transacciones",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barGroups: [
                          _buildBarGroup(0, approvedCount, Colors.green),
                          _buildBarGroup(1, pendingCount, Colors.amber),
                          _buildBarGroup(2, failureCount, Colors.red),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text("Aprobadas",
                                        style: TextStyle(fontSize: 14));
                                  case 1:
                                    return const Text("Pendientes",
                                        style: TextStyle(fontSize: 14));
                                  case 2:
                                    return const Text("Fallidas",
                                        style: TextStyle(fontSize: 14));
                                  default:
                                    return const Text("");
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildStatusCountTile(
                      "Aprobadas", approvedCount, Colors.green),
                  _buildStatusCountTile(
                      "Pendientes", pendingCount, Colors.amber),
                  _buildStatusCountTile("Fallidas", failureCount, Colors.red),
                ],
              ),
            ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, int value, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value.toDouble(),
          color: color,
          width: 25,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildStatusCountTile(String label, int count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.bar_chart, color: color),
        title: Text(label),
        trailing: Text(count.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
