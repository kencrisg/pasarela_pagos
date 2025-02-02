import 'package:flutter/material.dart';
import 'package:pasarela_app/api/admin_service.dart';
import 'package:pasarela_app/screens/widgets/transaction_admin_screen.dart';

class UserAdminScreen extends StatefulWidget {
  const UserAdminScreen({super.key});

  @override
  UserAdminScreenState createState() => UserAdminScreenState();
}

class UserAdminScreenState extends State<UserAdminScreen> {
  final AdminService _adminService = AdminService();
  List<dynamic> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    final users = await _adminService.getUsers();

    if (!mounted) return;

    setState(() {
      _users = users;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchUsers,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
              ? const Center(child: Text("No hay usuarios disponibles"))
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserTransactionsScreen(userId: user['user_id']),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID: ${user['user_id']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text("Nombre: ${user['name']}"),
                                    Text("Correo: ${user['email']}"),
                                    Text("API Token: ${user['api_token']}",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Align(
                                // 🔹 Alinea el icono en el centro verticalmente
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
