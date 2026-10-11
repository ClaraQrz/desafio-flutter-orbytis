import 'dart:io';

import 'package:dio/dio.dart';

import '../data/database.dart';
import '../repositories/inspection_repository.dart';
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

        if (success) {
          successCount++;
        }
      }
    } finally {
      _isSyncing = false;
    }

    return successCount;
  }

  Future<bool> syncOne(Inspection inspection) async {
    if (_isSyncing) return false;

    _isSyncing = true;
    try {
      return await _syncSingle(inspection);
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _syncSingle(Inspection inspection) async {
    final photoPath = inspection.photoPath;

    if (photoPath == null || photoPath.trim().isEmpty) {
      await _repo.markAsFailed(
        inspection.id,
        'A foto da inspeção não foi encontrada no aparelho.',
      );
      return false;
    }

    try {
      if (!await File(photoPath).exists()) {
        await _repo.markAsFailed(
          inspection.id,
          'A foto da inspeção não foi encontrada no aparelho.',
        );
        return false;
      }

      final formData = FormData.fromMap({
        'clientId': inspection.clientId,
        'workOrderId': inspection.workOrderId,
        'observation': inspection.observation,
        'latitude': inspection.latitude,
        'longitude': inspection.longitude,
        'capturedAt': inspection.capturedAt.toUtc().toIso8601String(),
        'photo': await MultipartFile.fromFile(photoPath),
      });

      final response = await ApiClient.dio.post('/inspections', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final serverId = data is Map ? data['id'] : null;

        if (serverId == null || serverId.toString().isEmpty) {
          await _repo.markAsFailed(
            inspection.id,
            'O servidor não retornou o identificador da inspeção.',
          );
          return false;
        }

        await _repo.markAsSynced(inspection.id, serverId.toString());
        return true;
      }

      await _repo.markAsFailed(
        inspection.id,
        'Resposta inesperada do servidor.',
      );
      return false;
    } on FileSystemException {
      await _repo.markAsFailed(
        inspection.id,
        'Não foi possível acessar a foto da inspeção.',
      );
      return false;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) rethrow;
      await _repo.markAsFailed(inspection.id, _describeError(e));
      return false;
    } catch (_) {
      await _repo.markAsFailed(
        inspection.id,
        'Erro inesperado ao sincronizar esta inspeção.',
      );
      return false;
    }
  }

  String _describeError(DioException e) {
    if (e.response?.statusCode == 400) {
      final data = e.response?.data;

      if (data is Map && data['message'] is String) {
        return data['message'] as String;
      }

      return 'Dados inválidos.';
    }

    return 'Falha de conexão. Será reenviado quando a internet voltar.';
  }
}
