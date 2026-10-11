enum WorkOrderStatus {
  open('open'),
  inProgress('in_progress'),
  done('done');

  const WorkOrderStatus(this.value);

  final String value;

  static WorkOrderStatus? fromValue(String value) {
    for (final status in values) {
      if (status.value == value) return status;
    }
    return null;
  }
}

enum WorkOrderPriority {
  high,
  medium,
  low;

  String get value => name;

  static WorkOrderPriority? fromValue(String value) {
    for (final priority in values) {
      if (priority.value == value) return priority;
    }
    return null;
  }
}
