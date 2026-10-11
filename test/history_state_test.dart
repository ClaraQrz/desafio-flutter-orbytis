import 'package:flutter_test/flutter_test.dart';
import 'package:inspecampo/blocs/history/history_bloc.dart';
import 'package:inspecampo/data/database.dart';
import 'package:inspecampo/models/inspection_status.dart';

Inspection _inspection(int id, String status) {
  return Inspection(
    id: id,
    clientId: 'client-$id',
    workOrderId: 'wo-$id',
    observation: 'observação de teste',
    capturedAt: DateTime(2026, 1, 1),
    status: status,
  );
}

void main() {
  group('HistoryState', () {
    final inspections = [
      _inspection(1, InspectionStatus.draft.value),
      _inspection(2, InspectionStatus.pending.value),
      _inspection(3, InspectionStatus.synced.value),
      _inspection(4, InspectionStatus.failed.value),
      _inspection(5, InspectionStatus.pending.value),
    ];

    test('começa carregando, sem sincronizar e com filtro Todos', () {
      const state = HistoryState();

      expect(state.isLoading, isTrue);
      expect(state.isSyncing, isFalse);
      expect(state.filter, HistoryFilter.all);
      expect(state.filtered, isEmpty);
    });

    test('filtro Todos devolve todas as inspeções', () {
      final state = HistoryState(isLoading: false, inspections: inspections);

      expect(state.filtered, hasLength(5));
    });

    test('filtro Pendente devolve só as pendentes', () {
      final state = HistoryState(
        isLoading: false,
        inspections: inspections,
        filter: HistoryFilter.pending,
      );

      expect(state.filtered.map((i) => i.id), [2, 5]);
    });

    test('filtro sem nenhuma inspeção do status devolve lista vazia', () {
      final state = HistoryState(
        isLoading: false,
        inspections: [_inspection(1, InspectionStatus.synced.value)],
        filter: HistoryFilter.draft,
      );

      expect(state.filtered, isEmpty);
    });
  });
}
