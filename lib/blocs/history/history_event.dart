part of 'history_bloc.dart';

@freezed
sealed class HistoryEvent with _$HistoryEvent {

  const factory HistoryEvent.loadRequested({Completer<void>? completer}) =
      HistoryLoadRequested;

  const factory HistoryEvent.filterChanged(HistoryFilter filter) =
      HistoryFilterChanged;

  const factory HistoryEvent.syncRequested() = HistorySyncRequested;

  const factory HistoryEvent.retryRequested(Inspection inspection) =
      HistoryRetryRequested;

  const factory HistoryEvent.connectivityChanged(bool isOnline) =
      HistoryConnectivityChanged;
}