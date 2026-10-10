import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/database.dart';
import '../../repositories/inspection_repository.dart';
import '../../services/photo_service.dart';

part 'inspection_form_event.dart';
part 'inspection_form_state.dart';
part 'inspection_form_bloc.freezed.dart';

class InspectionFormBloc
    extends Bloc<InspectionFormEvent, InspectionFormState> {
  InspectionFormBloc(
    this._repo, {
    required this._photoService,
    required this.workOrderId,
    this.createdBy,
    Inspection? draft,
  })  : _draft = draft,
        super(InspectionFormState(photoPath: draft?.photoPath)) {
    on<PhotoSourceSelected>(_onPhotoSelected);
    on<PhotoRemoved>(_onPhotoRemoved);
    on<DraftSubmitted>(_onDraftSubmitted);
    on<InspectionConcluded>(_onInspectionConcluded);
  }

  final InspectionRepository _repo;
  final PhotoService _photoService;
  final String workOrderId;

  final String? createdBy;

  final Inspection? _draft;

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
      final savedPath = await _photoService.pick(event.source);
      if (savedPath == null) {
        emit(state.copyWith(status: InspectionFormStatus.idle));
        return;
      }

      emit(state.copyWith(
        status: InspectionFormStatus.idle,
        photoPath: savedPath,
      ));
    } catch (_) {
      _notify(emit, 'Não foi possível obter a foto.');
    }
  }

  void _onPhotoRemoved(
    PhotoRemoved event,
    Emitter<InspectionFormState> emit,
  ) {
    emit(state.copyWith(photoPath: null));
  }

  Future<void> _onDraftSubmitted(
    DraftSubmitted event,
    Emitter<InspectionFormState> emit,
  ) async {
    if (state.isSubmitting) return;

    final observation = event.observation.trim();
    if (observation.isEmpty) {
      _notify(emit, 'Adicione ao menos uma observação antes de salvar.');
      return;
    }

    emit(state.copyWith(status: InspectionFormStatus.submitting));
    try {
      final draft = _draft;
      if (draft == null) {
        await _repo.createDraft(
          workOrderId: workOrderId,
          observation: observation,
          photoPath: state.photoPath,
          latitude: event.latitude,
          longitude: event.longitude,
          createdBy: createdBy,
        );
      } else {
        await _repo.updateDraft(
          id: draft.id,
          observation: observation,
          photoPath: state.photoPath,
          latitude: event.latitude,
          longitude: event.longitude,
        );
      }
      _notify(
        emit,
        draft == null ? 'Rascunho salvo localmente.' : 'Rascunho atualizado.',
        status: InspectionFormStatus.success,
      );
    } catch (_) {
      _notify(emit, 'Erro ao salvar o rascunho.');
    }
  }

  Future<void> _onInspectionConcluded(
    InspectionConcluded event,
    Emitter<InspectionFormState> emit,
  ) async {
    if (state.isSubmitting) return;

    final observation = event.observation.trim();
    String? error;
    if (observation.length < 10) {
      error = 'A observação precisa ter pelo menos 10 caracteres.';
    } else if (state.photoPath == null) {
      error = 'Adicione uma foto antes de concluir.';
    } else if (event.latitude == null || event.longitude == null) {
      error = 'Confirme sua localização no mapa antes de concluir.';
    }
    if (error != null) {
      _notify(emit, error);
      return;
    }

    emit(state.copyWith(status: InspectionFormStatus.submitting));
    try {
      final draft = _draft;
      if (draft == null) {
        await _repo.createPending(
          workOrderId: workOrderId,
          observation: observation,
          photoPath: state.photoPath!,
          latitude: event.latitude!,
          longitude: event.longitude!,
          createdBy: createdBy,
        );
      } else {
        await _repo.concludeDraft(
          id: draft.id,
          observation: observation,
          photoPath: state.photoPath!,
          latitude: event.latitude!,
          longitude: event.longitude!,
        );
      }
      _notify(
        emit,
        'Inspeção concluída, adicionada à fila de sincronização.',
        status: InspectionFormStatus.success,
      );
    } catch (_) {
      _notify(emit, 'Erro ao concluir a inspeção.');
    }
  }
}