import 'package:flutter/material.dart';
import 'package:pasarela_app/screens/admin/widgets/report_transaction_screen.dart';
import 'package:pasarela_app/screens/admin/widgets/report_user_screen.dart';

class ReportMainScreen extends StatelessWidget {
  const ReportMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              tabs: [
                Tab(icon: Icon(Icons.payment), text: "Transacciones"),
                Tab(icon: Icon(Icons.people), text: "Usuarios"),
              ],
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: TabBarView(
                children: [
                  ReportTransactionScreen(),
                  ReportUserScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
