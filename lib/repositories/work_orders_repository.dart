import 'package:inspecampo/models/work_order.dart';
import 'package:inspecampo/services/work_orders_service.dart';

class WorkOrdersRepository {
  WorkOrdersRepository({required WorkOrdersService workOrdersService})
    : _service = workOrdersService;

  final WorkOrdersService _service;

  Future<List<WorkOrder>> getWorkOrders() {
    return _service.getWorkOrders();
  }
}
