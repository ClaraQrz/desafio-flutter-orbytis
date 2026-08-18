import 'package:dio/dio.dart';
import '../data/database.dart';
import '../data/inspection_repository.dart';
import 'api_client.dart';

class SyncService {
  final InspectionRepository _repo;
  bool _isSyncing = false;

  SyncService(this._repo);

  bool get isSyncing => _isSyncing;

  Future<int> syncAll() async {
    if (_isSyncing) return 0; 
    _isSyncing = true;
    int successCount = 0;

    try {
      final pendingItems = await _repo.getPendingOrFailed();
      for (final inspection in pendingItems) {
        final success = await _syncSingle(inspection);
        if (success) successCount++;
      }
    } finally {
      _isSyncing = false;
    }

    return successCount;
  }

  Future<bool> syncOne(Inspection inspection) => _syncSingle(inspection);

  Future<bool> _syncSingle(Inspection inspection) async {
    try {
      final formData = FormData.fromMap({
        'clientId': inspection.clientId,
        'workOrderId': inspection.workOrderId,
        'observation': inspection.observation,
        if (inspection.condition != null) 'condition': inspection.condition,
        'latitude': inspection.latitude,
        'longitude': inspection.longitude,
        'capturedAt': inspection.capturedAt.toUtc().toIso8601String(),
        'photo': await MultipartFile.fromFile(inspection.photoPath!),
      });

      final response = await ApiClient.dio.post('/inspections', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final serverId = response.data['id'] as String;
        await _repo.markAsSynced(inspection.id, serverId);
        return true;
      }

      await _repo.markAsFailed(inspection.id, 'Resposta inesperada do servidor.');
      return false;
    } on DioException catch (e) {
      final message = _describeError(e);
      await _repo.markAsFailed(inspection.id, message);
      return false;
    }
  }

  String _describeError(DioException e) {
    if (e.response?.statusCode == 400) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'] as String;
      }
      return 'Dados inválidos.';
    }
    if (e.response?.statusCode == 401) {
      return 'Sessão expirada. Faça login novamente.';
    }
    return 'Falha de conexão. Será reenviado quando a internet voltar.';
  }
}