import 'package:flutter/material.dart';
import '../services/token_storage.dart';
import '../services/user_storage.dart';
import '../models/user.dart';

class WorkOrdersScreen extends StatefulWidget {
  const WorkOrdersScreen({super.key});

  @override
  State<WorkOrdersScreen> createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends State<WorkOrdersScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await UserStorage.getUser();
    if (mounted) setState(() => _user = user);
  }

  Future<void> _handleLogout() async {
    await TokenStorage.clearToken();
    await UserStorage.clearUser();
    if (mounted) Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user != null ? 'Olá, ${_user!.name}' : 'Ordens de Serviço'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _handleLogout),
        ],
      ),
      body: const Center(child: Text('Lista de OS (Em breve)')),
    );
  }
}