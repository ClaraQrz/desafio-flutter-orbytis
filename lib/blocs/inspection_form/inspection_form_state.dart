part of 'inspection_form_bloc.dart';

enum InspectionFormStatus {idle, pickingPhoto, submitting, success}


@freezed
class InspectionFormState {
  const InspectionFormState({
    this.status = InspectionFormStatus.idle,
    this.photoPath,
    this.message,
});
  final InspectionFormStatus status;
  final String? photoPath;
  final String? message;

  bool get isSubmitting => status == InspectionFormStatus.submitting;
  bool get isSuccess => status == InspectionFormStatus.success;

  InspectionFormState copyWith({
    InspectionFormStatus? status,
    String? photoPath,
    String? message,
}) {
    return InspectionFormState(
      status: status ?? this.status,
      photoPath: photoPath ?? this.photoPath,
      message: message,
    );
  }
}
