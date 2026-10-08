import 'package:drift/drift.dart' show Value;
import 'package:inspecampo/data/database.dart';
import 'package:inspecampo/models/work_order.dart';
import 'package:inspecampo/services/connectivity_service.dart';
import 'package:inspecampo/services/work_orders_service.dart';

class WorkOrdersRepository {
  WorkOrdersRepository({
    required WorkOrdersService workOrdersService,
    required AppDatabase database,
    required ConnectivityService connectivity,
  }) : _service = workOrdersService,
        _db = database,
        _connectivity = connectivity;

  final WorkOrdersService _service;
  final AppDatabase _db;
  final ConnectivityService _connectivity;

  Future<List<WorkOrder>> getWorkOrders() async {
    if (!await _connectivity.isOnline) {
      final cached = await _readCache();
      if (cached.isNotEmpty) return cached;
      throw WorkOrdersException(
        'Sem conexão e nenhuma ordem de serviço salva no aparelho.',
      );
    }

    try {
      final orders = await _service.getWorkOrders();
      await _saveCache(orders);
      return orders;
    } on WorkOrdersException catch (e) {
      if (e.isSessionExpired) rethrow;

      final cached = await _readCache();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<void> _saveCache(List<WorkOrder> orders) async {
    await _db.transaction(() async {
      await _db.delete(_db.cachedWorkOrders).go();
      await _db.batch((batch) {
        batch.insertAll(
          _db.cachedWorkOrders,
          orders
              .map(
                (o) => CachedWorkOrdersCompanion.insert(
              id: o.id,
              code: o.code,
              title: o.title,
              description: o.description,
              address: o.address,
              priority: o.priority,
              status: o.status,
              latitude: Value(o.latitude),
              longitude: Value(o.longitude),
            ),
          )
              .toList(),
        );
      });
    });
  }

  Future<List<WorkOrder>> _readCache() async {
    final rows = await _db.select(_db.cachedWorkOrders).get();
    return rows
        .map(
          (r) => WorkOrder(
        id: r.id,
        code: r.code,
        title: r.title,
        description: r.description,
        address: r.address,
        priority: r.priority,
        status: r.status,
        latitude: r.latitude,
        longitude: r.longitude,
      ),
    )
        .toList();
  }
}