import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../repositories/inspection_repository.dart';

part 'inspection_form_event.dart';
part 'inspection_form_state.dart';
part 'inspection_form_bloc.freezed.dart';

class InspectionFormBloc
    extends Bloc<InspectionFormEvent, InspectionFormState> {
  InspectionFormBloc(this._repo, {required this.workOrderId})
      : super(const InspectionFormState()) {
    on<PhotoSourceSelected>(_onPhotoSelected);
    on<PhotoRemoved>(_onPhotoRemoved);
    on<DraftSubmitted>(_onDraftSubmitted);
    on<InspectionConcluded>(_onInspectionConcluded);
  }

  final InspectionRepository _repo;
  final String workOrderId;

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
      final xfile = await ImagePicker()
          .pickImage(source: event.source, imageQuality: 80);
      if (xfile == null) {
        emit(state.copyWith(status: InspectionFormStatus.idle));
        return;
      }

      final docsDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory(p.join(docsDir.path, 'inspection_photos'));
      if (!await photosDir.exists()) await photosDir.create(recursive: true);

      final savedPath = p.join(
        photosDir.path,
        '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await File(xfile.path).copy(savedPath);

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
      await _repo.createDraft(
        workOrderId: workOrderId,
        observation: observation,
        photoPath: state.photoPath,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      _notify(
        emit,
        'Rascunho salvo localmente.',
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
      await _repo.createPending(
        workOrderId: workOrderId,
        observation: observation,
        photoPath: state.photoPath!,
        latitude: event.latitude!,
        longitude: event.longitude!,
      );
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