import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'database.dart';

class InspectionRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  InspectionRepository(this._db);

  Future<int> _insert({
    required String workOrderId,
    required String observation,
    String? condition,
    String? photoPath,
    double? latitude,
    double? longitude,
    required String status,
  }) {
    return _db.into(_db.inspections).insert(
          InspectionsCompanion.insert(
            clientId: _uuid.v4(),
            workOrderId: workOrderId,
            observation: observation,
            condition: Value(condition),
            photoPath: Value(photoPath),
            latitude: Value(latitude),
            longitude: Value(longitude),
            capturedAt: DateTime.now(),
            status: Value(status),
          ),
        );
  }

  Future<int> createDraft({
    required String workOrderId,
    required String observation,
    String? condition,
    String? photoPath,
    double? latitude,
    double? longitude,
  }) {
    return _insert(
      workOrderId: workOrderId,
      observation: observation,
      condition: condition,
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
      status: 'draft',
    );
  }

  Future<int> createPending({
    required String workOrderId,
    required String observation,
    String? condition,
    required String photoPath,
    required double latitude,
    required double longitude,
  }) {
    return _insert(
      workOrderId: workOrderId,
      observation: observation,
      condition: condition,
      photoPath: photoPath,
      latitude: latitude,
      longitude: longitude,
      status: 'pending',
    );
  }

  Future<void> markAsPending(int id) {
    return (_db.update(_db.inspections)..where((t) => t.id.equals(id)))
        .write(const InspectionsCompanion(status: Value('pending')));
  }

  Future<List<Inspection>> getAll() {
    return (_db.select(_db.inspections)
          ..orderBy([(t) => OrderingTerm.desc(t.capturedAt)]))
        .get();
  }

  Future<List<Inspection>> getPendingOrFailed() {
    return (_db.select(_db.inspections)
          ..where((t) => t.status.equals('pending') | t.status.equals('failed')))
        .get();
  }

  Future<void> markAsSynced(int id, String serverId) {
    return (_db.update(_db.inspections)..where((t) => t.id.equals(id))).write(
      InspectionsCompanion(
        status: const Value('synced'),
        serverId: Value(serverId),
        syncedAt: Value(DateTime.now()),
        errorMessage: const Value(null),
      ),
    );
  }

  Future<void> markAsFailed(int id, String errorMessage) {
    return (_db.update(_db.inspections)..where((t) => t.id.equals(id))).write(
      InspectionsCompanion(
        status: const Value('failed'),
        errorMessage: Value(errorMessage),
      ),
    );
  }
}