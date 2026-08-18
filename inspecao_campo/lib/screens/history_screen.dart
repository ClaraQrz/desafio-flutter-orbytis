import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../data/database.dart';
import '../data/inspection_repository.dart';
import '../services/sync_service.dart';
import '../theme/app_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _repo = InspectionRepository(appDatabase);
  late final SyncService _syncService;

  List<Inspection> _all = [];
  String _filter = 'all'; 
  bool _isSyncing = false;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  @override
  void initState() {
    super.initState();
    _syncService = SyncService(_repo);
    _loadInspections();
    _listenToConnectivity();
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }

  Future<void> _loadInspections() async {
    final list = await _repo.getAll();
    if (mounted) setState(() => _all = list);
  }

  void _listenToConnectivity() {
    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((results) {
      final isOnline = results.any((r) => r != ConnectivityResult.none);
      if (isOnline) _runSync(silent: true);
    });
  }

  Future<void> _runSync({bool silent = false}) async {
    if (_isSyncing) return;
    setState(() => _isSyncing = true);
    final count = await _syncService.syncAll();
    await _loadInspections();
    if (mounted) {
      setState(() => _isSyncing = false);
      if (!silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(count > 0
                ? '$count inspeção(ões) sincronizada(s).'
                : 'Nada novo para sincronizar.'),
          ),
        );
      }
    }
  }

  Future<void> _retry(Inspection inspection) async {
    final success = await _syncService.syncOne(inspection);
    await _loadInspections();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Sincronizado com sucesso.'
              : 'Falha ao sincronizar. Será tentado novamente mais tarde.'),
        ),
      );
    }
  }

  List<Inspection> get _filtered {
    if (_filter == 'all') return _all;
    return _all.where((i) => i.status == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          IconButton(
            icon: _isSyncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                : const Icon(Icons.sync),
            onPressed: _isSyncing ? null : () => _runSync(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('Nenhuma inspeção neste filtro.'))
                : RefreshIndicator(
                    onRefresh: _loadInspections,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final inspection = _filtered[index];
                        return _InspectionCard(
                          inspection: inspection,
                          onRetry: inspection.status == 'failed'
                              ? () => _retry(inspection)
                              : null,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final options = {
      'all': 'Todos',
      'draft': 'Rascunho',
      'pending': 'Pendente',
      'synced': 'Sincronizado',
      'failed': 'Falhou',
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: options.entries.map((entry) {
          final selected = _filter == entry.key;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: selected,
              onSelected: (_) => setState(() => _filter = entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _InspectionCard extends StatelessWidget {
  final Inspection inspection;
  final VoidCallback? onRetry;

  const _InspectionCard({required this.inspection, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OS #${inspection.workOrderId}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    'Data/hora: ${_formatDate(inspection.capturedAt)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorForSyncStatus(inspection.status)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      labelForSyncStatus(inspection.status),
                      style: TextStyle(
                        color: colorForSyncStatus(inspection.status),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  if (inspection.status == 'failed' &&
                      inspection.errorMessage != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      inspection.errorMessage!,
                      style: const TextStyle(color: AppColors.failed, fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: const Text('Tentar novamente'),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day.toString().padLeft(2, '0')}/'
        '${local.month.toString().padLeft(2, '0')}/${local.year} '
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}