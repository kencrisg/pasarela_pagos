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
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No hay usuarios disponibles",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _fetchUsers,
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
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID: ${user['user_id']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text("Nombre: ${user['name']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        )),
                                    Text("Correo: ${user['email']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        )),
                                    Text("API Token: ${user['api_token']}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
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
