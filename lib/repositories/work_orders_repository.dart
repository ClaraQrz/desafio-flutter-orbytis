import 'package:drift/drift.dart';

import '../data/database.dart';
import '../models/work_order.dart';
import '../models/inspection_status.dart';
import '../models/work_order_status.dart';
import '../services/connectivity_service.dart';
import '../services/work_orders_service.dart';

class WorkOrdersRepository {
  WorkOrdersRepository({
    required WorkOrdersService workOrdersService,
    required AppDatabase database,
    required this._connectivity,
  }) : _service = workOrdersService,
       _db = database;

  final WorkOrdersService _service;
  final AppDatabase _db;
  final ConnectivityService _connectivity;

  Future<List<WorkOrder>> getWorkOrders() async {
    if (!await _connectivity.isOnline()) {
      final cached = await _readCache();
      if (cached.isNotEmpty) return _onlyAvailable(cached);
      throw WorkOrdersException(
        'Sem conexão e nenhuma ordem de serviço salva no aparelho.',
      );
    }

    try {
      final orders = await _service.getWorkOrders();
      await _saveCache(orders);
      return await _onlyAvailable(orders);
    } on WorkOrdersException catch (e) {
      if (e.isSessionExpired) rethrow;

      final cached = await _readCache();
      if (cached.isNotEmpty) return _onlyAvailable(cached);
      rethrow;
    }
  }

  Future<WorkOrder?> getCachedWorkOrder(String id) async {
    final cached = await _readCache();
    for (final o in cached) {
      if (o.id == id) return o;
    }
    return null;
  }

  Future<Set<String>> _inspectedWorkOrderIds() async {
    final rows = await _db.select(_db.inspections).get();
    return {
      for (final r in rows)
        if (r.status != InspectionStatus.draft.value) r.workOrderId,
    };
  }

  Future<Set<String>> _workOrderIdsWithInspections() async {
    final rows = await _db.select(_db.inspections).get();
    return {for (final r in rows) r.workOrderId};
  }

  Future<List<WorkOrder>> _onlyAvailable(List<WorkOrder> orders) async {
    final inspected = await _inspectedWorkOrderIds();
    return orders
        .where(
          (o) =>
              o.status != WorkOrderStatus.done.value &&
              !inspected.contains(o.id),
        )
        .toList();
  }

  Future<void> _saveCache(List<WorkOrder> orders) async {
    final keepIds = (await _workOrderIdsWithInspections()).toList();

    await _db.transaction(() async {
      await (_db.delete(
        _db.cachedWorkOrders,
      )..where((t) => t.id.isNotIn(keepIds))).go();

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
          mode: InsertMode.insertOrReplace,
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
