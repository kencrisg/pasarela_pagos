import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pasarela_app/api/admin_service.dart';

class UserReportScreen extends StatefulWidget {
  final int userId;
  const UserReportScreen({super.key, required this.userId});

  @override
  UserReportScreenState createState() => UserReportScreenState();
}

class UserReportScreenState extends State<UserReportScreen> {
  final AdminService _adminService = AdminService();
  bool _isLoading = true;
  int approved = 0;
  int pending = 0;
  int failed = 0;

  @override
  void initState() {
    super.initState();
    _fetchTransactionReport();
  }

  Future<void> _fetchTransactionReport() async {
    final transactions = await _adminService.getUserTransactions(widget.userId);

    if (!mounted) return;

    setState(() {
      approved = transactions.where((t) => t['status'] == 'approved').length;
      pending = transactions.where((t) => t['status'] == 'pending').length;
      failed = transactions.where((t) => t['status'] == 'failure').length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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

                // 📊 Gráfica de Barras
                Expanded(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: (approved + pending + failed).toDouble(),
                      barGroups: [
                        _buildBar(approved, Colors.green, "Aprobadas"),
                        _buildBar(pending, Colors.orange, "Pendientes"),
                        _buildBar(failed, Colors.red, "Fallidas"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔢 Contadores de Estados
                _buildStatusTile("Aprobadas", approved, Colors.green),
                _buildStatusTile("Pendientes", pending, Colors.orange),
                _buildStatusTile("Fallidas", failed, Colors.red),
              ],
            ),
          );
  }

  BarChartGroupData _buildBar(int value, Color color, String label) {
    return BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: value.toDouble(),
          color: color,
          width: 30,
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  Widget _buildStatusTile(String label, int count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.analytics, color: color),
        title: Text(label),
        trailing: Text(count.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
