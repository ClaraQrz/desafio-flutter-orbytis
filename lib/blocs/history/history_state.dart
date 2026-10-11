part of 'history_bloc.dart';

enum HistoryFilter {
  all('Todos', null),
  draft('Rascunho', InspectionStatus.draft),
  pending('Pendente', InspectionStatus.pending),
  synced('Sincronizado', InspectionStatus.synced),
  failed('Falhou', InspectionStatus.failed);

  const HistoryFilter(this.label, this.status);

  final String label;
  final InspectionStatus? status;
}

@freezed
abstract class HistoryState with _$HistoryState {
  const HistoryState._();

  const factory HistoryState({
    @Default(true) bool isLoading,
    @Default(false) bool isSyncing,
    @Default(<Inspection>[]) List<Inspection> inspections,
    @Default(HistoryFilter.all) HistoryFilter filter,
    String? message,
  }) = _HistoryState;

  List<Inspection> get filtered {
    final status = filter.status;
    if (status == null) return inspections;
    return inspections.where((i) => i.status == status.value).toList();
  }
}
