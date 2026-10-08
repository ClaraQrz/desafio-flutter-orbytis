part of 'inspection_form_bloc.dart';

enum InspectionFormStatus { idle, pickingPhoto, submitting, success }

@freezed
abstract class InspectionFormState with _$InspectionFormState {
  const InspectionFormState._();

  const factory InspectionFormState({
    @Default(InspectionFormStatus.idle) InspectionFormStatus status,
    String? photoPath,

    String? message,
  }) = _InspectionFormState;

  bool get isSubmitting => status == InspectionFormStatus.submitting;
  bool get isSuccess => status == InspectionFormStatus.success;
}