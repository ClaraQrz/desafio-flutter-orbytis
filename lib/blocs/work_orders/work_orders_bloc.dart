import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/work_order.dart';
import '../../repositories/work_orders_repository.dart';
import '../../services/work_orders_service.dart';

part 'work_orders_event.dart';
part 'work_orders_state.dart';
part 'work_orders_bloc.freezed.dart';

class WorkOrdersBloc extends Bloc<WorkOrdersEvent, WorkOrdersState> {
  WorkOrdersBloc(this._repo) : super(const WorkOrdersState.loading()) {
    on<WorkOrdersLoadRequested>(_onLoadRequested);
    on<WorkOrdersRefreshRequested>(_onRefreshRequested);
  }

  final WorkOrdersRepository _repo;

  Completer<void>? _refreshCompleter;


  Future<void> refresh() {
    final pending = _refreshCompleter;
    if (pending != null) return pending.future;

    final completer = _refreshCompleter = Completer<void>();
    add(const WorkOrdersEvent.refreshRequested());
    return completer.future;
  }

  Future<void> _onLoadRequested(
    WorkOrdersLoadRequested event,
    Emitter<WorkOrdersState> emit,
  ) async {
    emit(const WorkOrdersState.loading());
    await _fetch(emit);
  }

  Future<void> _onRefreshRequested(
    WorkOrdersRefreshRequested event,
    Emitter<WorkOrdersState> emit,
  ) async {
    try {
      await _fetch(emit);
    } finally {
      _refreshCompleter?.complete();
      _refreshCompleter = null;
    }
  }

  Future<void> _fetch(Emitter<WorkOrdersState> emit) async {
    try {
      final orders = await _repo.getWorkOrders();

      emit(
        orders.isEmpty
            ? const WorkOrdersState.empty()
            : WorkOrdersState.loaded(orders),
      );
    } on WorkOrdersException catch (e) {
      emit(
        WorkOrdersState.failure(
          message: e.message,
          isSessionExpired: e.isSessionExpired,
        ),
      );
    } catch (_) {
      emit(
        const WorkOrdersState.failure(
          message: 'Ocorreu um erro inesperado. Tente novamente.',
        ),
      );
    }
  }
}