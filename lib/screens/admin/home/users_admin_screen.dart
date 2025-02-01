import 'package:flutter/material.dart';
import 'package:pasarela_app/api/admin_service.dart';

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

    setState(() {
      _users = users;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _fetchUsers,
            child: const Text("Actualizar Datos"),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _users.isEmpty
                  ? const Center(child: Text("No hay usuarios disponibles"))
                  : OrientationBuilder(
                      builder: (context, orientation) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.portrait ? 1 : 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
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
                            );
                          },
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
