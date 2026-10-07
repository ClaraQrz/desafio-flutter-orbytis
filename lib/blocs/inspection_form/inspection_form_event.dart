part of 'inspection_form_bloc.dart';

@freezed
class InspectionFormEvent with _$InspectionFormEvent {
  const factory InspectionFormEvent.photoSourceSelected(ImageSource source) =
      _PhotoSourceSelected;

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
