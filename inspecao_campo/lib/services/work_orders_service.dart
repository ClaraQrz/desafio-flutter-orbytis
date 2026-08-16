import 'package:dio/dio.dart';
import '../models/work_order.dart';
import 'api_client.dart';

class WorkOrdersException implements Exception {
  final String message;
  WorkOrdersException(this.message);
}

class WorkOrdersService {
  Future<List<WorkOrder>> getWorkOrders() async {
    try {
      final response = await ApiClient.dio.get('/work-orders');
      final List<dynamic> data = response.data;
      return data
        .map((json) => WorkOrder.fromJson(json as Map<String, dynamic>))
        .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw WorkOrdersException('Sessão expirada. Faça login novamente.');
      }
      throw WorkOrdersException('Não foi possível carregar as ordens de serviço. Verifique sua conexão.');
    }
  }
}
