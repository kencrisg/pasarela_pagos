import 'package:flutter/material.dart';
import 'package:pasarela_app/api/admin_service.dart';

class UserTransactionsScreen extends StatefulWidget {
  final int userId;

  const UserTransactionsScreen({super.key, required this.userId});

  @override
  UserTransactionsScreenState createState() => UserTransactionsScreenState();
}

class UserTransactionsScreenState extends State<UserTransactionsScreen> {
  final AdminService _adminService = AdminService();
  List<dynamic> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    setState(() {
      _isLoading = true;
    });

    final transactions = await _adminService.getUserTransactions(widget.userId);

    if (!mounted) return;

    setState(() {
      _transactions = transactions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transacciones del Usuario")),
      body: RefreshIndicator(
        onRefresh: _fetchTransactions,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _transactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "No hay transacciones disponibles",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed:
                              _fetchTransactions, // 🔥 Llama al método de actualización
                          icon: const Icon(Icons.refresh),
                          label: const Text("Actualizar"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: const Icon(Icons.attach_money,
                              size: 30, color: Colors.green),
                          title: Text("Monto: \$${transaction['amount']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Fecha: ${transaction['creation_date']}"),
                              Text(
                                "Estado: ${transaction['status']}",
                                style: TextStyle(
                                  color: getStatusColor(transaction['status']),
                                  fontWeight: FontWeight
                                      .bold, // Opcional para resaltar el texto
                                ),
                              ),
                              Text("Orden ID: ${transaction['order_id']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'failure':
        return Colors.red;
      case 'pending':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
