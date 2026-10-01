class WorkOrder {
  final String id;
  final String code;
  final String title;
  final String description;
  final String address;
  final String priority;   // "high" | "medium" | "low"
  final String status;     // "open" | "in_progress" | "done"
  final double? latitude;
  final double? longitude;

  WorkOrder({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.address,
    required this.priority,
    required this.status,
    this.latitude,
    this.longitude,
  });

  factory WorkOrder.fromJson(Map<String, dynamic> json) {
    return WorkOrder(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      address: json['address'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}