enum InspectionStatus {
  draft,
  pending,
  synced,
  failed;

  String get value => name;

  static InspectionStatus? fromValue(String value) {
    for (final status in values) {
      if (status.value == value) return status;
    }
    return null;
  }
}
