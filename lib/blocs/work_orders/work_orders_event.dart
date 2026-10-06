part of 'work_orders_bloc.dart';

@freezed
sealed class WorkOrdersEvent with _$WorkOrdersEvent {
  const factory WorkOrdersEvent.loadRequested() = WorkOrdersLoadRequested;

  const factory WorkOrdersEvent.refreshRequested() = WorkOrdersRefreshRequested;
}