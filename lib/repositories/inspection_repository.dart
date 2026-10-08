import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../data/database.dart';

abstract final class InspectionStatus {
  static const draft = 'draft';
  static const pending = 'pending';
  static const synced = 'synced';
  static const failed = 'failed';
}

class InspectionRepository {
  InspectionRepository({required AppDatabase database}) : _db = database;

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> createDraft({
    required String workOrderId,
    required String observation,
    String? photoPath,
    double? latitude,
    double? longitude,
  }) {
    return _insert(
      status: InspectionStatus.draft,
      workOrderId: workOrderId,
      observation: observation,
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<String> createPending({
    required String workOrderId,
    required String observation,
    required String photoPath,
    required double latitude,
    required double longitude,
  }) {
    return _insert(
      status: InspectionStatus.pending,
      workOrderId: workOrderId,
      observation: observation,
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<List<Inspection>> getAll() {
    return (_db.select(_db.inspections)
      ..orderBy([(t) => OrderingTerm.desc(t.capturedAt)]))
        .get();
  }

  Future<List<Inspection>> getPendingOrFailed() {
    return (_db.select(_db.inspections)
      ..where(
            (t) => t.status.isIn([
          InspectionStatus.pending,
          InspectionStatus.failed,
        ]),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.capturedAt)]))
        .get();
  }

  Future<void> markAsSynced(int id, String serverId) {
    return (_db.update(_db.inspections)..where((t) => t.id.equals(id))).write(
      InspectionsCompanion(
        status: const Value(InspectionStatus.synced),
        serverId: Value(serverId),
        errorMessage: const Value(null),
      ),
    );
  }

  Future<void> markAsFailed(int id, String message) {
    return (_db.update(_db.inspections)..where((t) => t.id.equals(id))).write(
      InspectionsCompanion(
        status: const Value(InspectionStatus.failed),
        errorMessage: Value(message),
      ),
    );
  }

  Future<String> _insert({
    required String status,
    required String workOrderId,
    required String observation,
    String? photoPath,
    double? latitude,
    double? longitude,
  }) async {
    final clientId = _uuid.v4();
    await _db.into(_db.inspections).insert(
      InspectionsCompanion.insert(
        clientId: clientId,
        workOrderId: workOrderId,
        observation: observation,
        capturedAt: DateTime.now(),
        status: Value(status),
        photoPath: Value(photoPath),
        latitude: Value(latitude),
        longitude: Value(longitude),
      ),
    );
    return clientId;
  }
}