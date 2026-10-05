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
      event.completer?.complete();
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