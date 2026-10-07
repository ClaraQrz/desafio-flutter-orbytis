part of 'work_orders_bloc.dart';

@freezed
sealed class WorkOrdersState with _$WorkOrdersState {
  const factory WorkOrdersState.loading() = WorkOrdersLoading;

  const factory WorkOrdersState.empty() = WorkOrdersEmpty;

  const factory WorkOrdersState.loaded(List<WorkOrder> workOrders) =
      WorkOrdersLoaded;

  const factory WorkOrdersState.refreshing({
    required List<WorkOrder> workOrders,
    required Completer<void> completer,
  }) = WorkOrdersRefreshing;

  const factory WorkOrdersState.failure({
    required String message,
    @Default(false) bool isSessionExpired,
  }) = WorkOrdersFailure;
}