part of 'inspection_form_bloc.dart';

@freezed
sealed class InspectionFormEvent with _$InspectionFormEvent {

  const factory InspectionFormEvent.photoSourceSelected(PhotoSource source) =
      PhotoSourceSelected;

  const factory InspectionFormEvent.photoRemoved() = PhotoRemoved;

  const factory InspectionFormEvent.draftSubmitted({
    required String observation,
    double? latitude,
    double? longitude,
  }) = DraftSubmitted;

  const factory InspectionFormEvent.concluded({
    required String observation,
    double? latitude,
    double? longitude,
  }) = InspectionConcluded;
}