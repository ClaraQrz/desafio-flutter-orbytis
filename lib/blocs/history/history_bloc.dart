import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/database.dart';
import '../../repositories/inspection_repository.dart';
import '../../services/connectivity_service.dart';
import '../../services/sync_service.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required InspectionRepository repository,
    required SyncService syncService,
    required ConnectivityService connectivity,
  })  : _repo = repository,
        _syncService = syncService,
        super(const HistoryState()) {
    on<HistoryLoadRequested>(_onLoadRequested);
    on<HistoryFilterChanged>(_onFilterChanged);
    on<HistorySyncRequested>(_onSyncRequested);
    on<HistoryRetryRequested>(_onRetryRequested);
    on<HistoryConnectivityChanged>(_onConnectivityChanged);

    _connectivitySub = connectivity.onChanged.listen(
      (isOnline) => add(HistoryEvent.connectivityChanged(isOnline)),
    );
  }

  final InspectionRepository _repo;
  final SyncService _syncService;
  late final StreamSubscription<bool> _connectivitySub;

  Future<void> reload() {
    final completer = Completer<void>();
    add(HistoryEvent.loadRequested(completer: completer));
    return completer.future;
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    return super.close();
  }

  void _notify(Emitter<HistoryState> emit, String message) {
    emit(state.copyWith(message: message));
    emit(state.copyWith(message: null));
  }

  Future<void> _onLoadRequested(
    HistoryLoadRequested event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      final list = await _repo.getAll();
      emit(state.copyWith(isLoading: false, inspections: list));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
      _notify(emit, 'Não foi possível carregar o histórico.');
    } finally {
      final completer = event.completer;
      if (completer != null && !completer.isCompleted) completer.complete();
    }
  }

  void _onFilterChanged(
    HistoryFilterChanged event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onSyncRequested(
    HistorySyncRequested event,
    Emitter<HistoryState> emit,
  ) {
    return _sync(emit, silent: false);
  }

  Future<void> _onConnectivityChanged(
    HistoryConnectivityChanged event,
    Emitter<HistoryState> emit,
  ) async {
    if (!event.isOnline) return;
    await _sync(emit, silent: true);
  }

  Future<void> _sync(
    Emitter<HistoryState> emit, {
    required bool silent,
  }) async {
    if (state.isSyncing) return;
    emit(state.copyWith(isSyncing: true));

    try {
      final count = await _syncService.syncAll();
      final list = await _repo.getAll();
      emit(state.copyWith(isSyncing: false, inspections: list));

      if (!silent) {
        _notify(
          emit,
          count > 0
              ? '$count inspeção(ões) sincronizada(s).'
              : 'Nada novo para sincronizar.',
        );
      }
    } catch (_) {
      emit(state.copyWith(isSyncing: false));
      if (!silent) _notify(emit, 'Erro ao sincronizar. Tente novamente.');
    }
  }

  Future<void> _onRetryRequested(
    HistoryRetryRequested event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      final success = await _syncService.syncOne(event.inspection);
      final list = await _repo.getAll();
      emit(state.copyWith(inspections: list));
      _notify(
        emit,
        success
            ? 'Sincronizado com sucesso.'
            : 'Falha ao sincronizar. Será tentado novamente mais tarde.',
      );
    } catch (_) {
      _notify(emit, 'Erro ao sincronizar. Tente novamente.');
    }
  }
}