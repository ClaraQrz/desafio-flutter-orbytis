import 'package:flutter/material.dart';
import 'package:inspecao_campo/screens/inspection_form_screen.dart';
import '../models/user.dart';
import '../models/work_order.dart';
import '../services/token_storage.dart';
import '../services/user_storage.dart';
import '../services/work_orders_service.dart';
import '../theme/app_theme.dart';

class WorkOrdersScreen extends StatefulWidget {
  const WorkOrdersScreen({super.key});

  @override
  State<WorkOrdersScreen> createState() => _WorkOrdersScreenState();
}

enum _ScreenState { loading, empty, error, loaded }

class _WorkOrdersScreenState extends State<WorkOrdersScreen> {
  final _service = WorkOrdersService();
  User? _user;

  _ScreenState _state = _ScreenState.loading;
  List<WorkOrder> _workOrders = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadWorkOrders();
  }

  Future<void> _loadUser() async {
    final user = await UserStorage.getUser();
    if (mounted) setState(() => _user = user);
  }

  Future<void> _loadWorkOrders() async {
    setState(() => _state = _ScreenState.loading);
    try {
      final orders = await _service.getWorkOrders();
      setState(() {
        _workOrders = orders;
        _state = orders.isEmpty ? _ScreenState.empty : _ScreenState.loaded;
      });
    } on WorkOrdersException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _state = _ScreenState.error;
      });
    }
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
          IconButton(icon: const Icon(Icons.history), onPressed: () => Navigator.of(context).pushNamed('/history'),
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _handleLogout),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case _ScreenState.loading:
        return const Center(child: CircularProgressIndicator());

      case _ScreenState.empty:
        return RefreshIndicator(
          onRefresh: _loadWorkOrders,
          child: ListView(
            children: const [
              SizedBox(height: 120),
              Center(child: Text('Nenhuma ordem de serviço no momento.')),
            ],
          ),
        );

      case _ScreenState.error:
  return RefreshIndicator(
    onRefresh: _loadWorkOrders,
    child: ListView(
      children: [
        const SizedBox(height: 100),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  _errorMessage ?? 'Falha ao carregar ordens de serviço.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: OutlinedButton.icon(
                    onPressed: _loadWorkOrders,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

      case _ScreenState.loaded:
        return RefreshIndicator(
          onRefresh: _loadWorkOrders,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _workOrders.length,
            itemBuilder: (context, index) {
              final workOrder = _workOrders[index];
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => InspectionFormScreen(workOrder: workOrder)),
                ),
                child: _WorkOrderCard(workOrder: workOrder),
              );
            },
          ),
        );
    }
  }
}

class _WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;

  const _WorkOrderCard({required this.workOrder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workOrder.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(workOrder.address,
                style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Badge(
                  label: labelForPriority(workOrder.priority),
                  color: colorForPriority(workOrder.priority),
                  withDot: true,
                ),
                _Badge(
                  label: labelForWorkOrderStatus(workOrder.status),
                  color: colorForWorkOrderStatus(workOrder.status),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final bool withDot;

  const _Badge({required this.label, required this.color, this.withDot = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (withDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ],
      ),
    );
  }
}