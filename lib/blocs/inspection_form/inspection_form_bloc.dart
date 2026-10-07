import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspection_form_event.dart';
part 'inspection_form_state.dart';
part 'inspection_form_bloc.freezed.dart';

class InspectionFormBloc extends Bloc<InspectionFormEvent, InspectionFormState> {
  InspectionFormBloc(this._repo{required this.workOrderId})
      : super(const InspectionFormState()) {
    on<PhotoSourceSelected>(_onPhotoSelected);
    on<DraftSubmitted>(_onDraftSubmitted);
    on<InspectionConcluded>(_onInspectionConcluded);
    }

    final InspectionRepository _repo;
    final dynamic workOrderId;
  }
  void _notify(
     Emitter<InspectionFormState> emit,
     String message, {
       InspectionFormStatus status = InspectionFormStatus.idle,
   }) {
      emit(state.copyWith(status: status, message: message));
      emit(state.copyWith(message: null));
}
  Future<void> _onPhotoSelected(
      PhotoSourceSelected event,
      Emitter<InspectionFormState> emit,
      ) async {
      emit(state.copyWith(status: InspectionFormStatus.pickingPhoto));
      try {
        final xfile = await ImagePicker().pickImage(event.source, imageQuality: 80);
        if (xfile == null) {
          emit(state.copyWith(status: InspectionFormStatus.idle));
          return;
        }
      }
  }


