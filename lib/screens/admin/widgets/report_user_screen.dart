import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pasarela_app/api/admin_service.dart';

class ReportUserScreen extends StatefulWidget {
  const ReportUserScreen({super.key});

  @override
  ReportUserScreenState createState() => ReportUserScreenState();
}

class ReportUserScreenState extends State<ReportUserScreen> {
  final AdminService _adminService = AdminService();

  bool _isLoading = true;
  Map<String, int> userTransactionCounts = {};

  @override
  void initState() {
    super.initState();
    _fetchUserTransactionData();
  }

  Future<void> _fetchUserTransactionData() async {
    final transactions = await _adminService.getTransactions();

    if (!mounted) return;

    Map<String, int> userCount = {};
    for (var transaction in transactions) {
      String userName = transaction['user']['name'];
      userCount[userName] = (userCount[userName] ?? 0) + 1;
    }

    setState(() {
      userTransactionCounts = userCount;
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
                  "Usuarios con más Transacciones",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: userTransactionCounts.entries.map((entry) {
                      return _buildUserTransactionTile(entry.key, entry.value,
                          Theme.of(context).colorScheme.primary);
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return userTransactionCounts.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: "${entry.value}",
        color: Colors.primaries[
            userTransactionCounts.keys.toList().indexOf(entry.key) %
                Colors.primaries.length],
        radius: 50,
      );
    }).toList();
  }

  Widget _buildUserTransactionTile(String userName, int count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.person, color: color),
        title: Text(userName),
        trailing: Text(count.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
