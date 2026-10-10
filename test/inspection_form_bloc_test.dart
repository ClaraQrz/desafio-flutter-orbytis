import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspecampo/blocs/inspection_form/inspection_form_bloc.dart';
import 'package:inspecampo/repositories/inspection_repository.dart';
import 'package:inspecampo/services/photo_service.dart';
import 'package:mocktail/mocktail.dart';

class MockInspectionRepository extends Mock implements InspectionRepository {}

class MockPhotoService extends Mock implements PhotoService {}

void main() {
  late MockInspectionRepository repo;
  late MockPhotoService photoService;

  setUp(() {
    repo = MockInspectionRepository();
    photoService = MockPhotoService();
  });

  InspectionFormBloc buildBloc() => InspectionFormBloc(
    repo,
    photoService: photoService,
    workOrderId: 'wo-1',
    createdBy: 'Técnico Teste',
  );

  const observation = 'Observação com mais de dez caracteres';

  group('foto', () {
    blocTest<InspectionFormBloc, InspectionFormState>(
      'guarda o caminho da foto escolhida',
      setUp: () => when(
        () => photoService.pick(PhotoSource.camera),
      ).thenAnswer((_) async => '/fotos/1.jpg'),
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.photoSourceSelected(PhotoSource.camera),
      ),
      expect: () => [
        const InspectionFormState(status: InspectionFormStatus.pickingPhoto),
        const InspectionFormState(photoPath: '/fotos/1.jpg'),
      ],
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'volta ao normal quando o usuário cancela',
      setUp: () => when(
        () => photoService.pick(PhotoSource.gallery),
      ).thenAnswer((_) async => null),
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.photoSourceSelected(PhotoSource.gallery),
      ),
      expect: () => [
        const InspectionFormState(status: InspectionFormStatus.pickingPhoto),
        const InspectionFormState(),
      ],
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'avisa quando a foto não pode ser obtida',
      setUp: () => when(
        () => photoService.pick(PhotoSource.camera),
      ).thenThrow(Exception('sem câmera')),
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.photoSourceSelected(PhotoSource.camera),
      ),
      expect: () => [
        const InspectionFormState(status: InspectionFormStatus.pickingPhoto),
        const InspectionFormState(
          message: 'Não foi possível obter a foto.',
        ),
        const InspectionFormState(),
      ],
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'remove a foto',
      build: buildBloc,
      seed: () => const InspectionFormState(photoPath: '/fotos/1.jpg'),
      act: (bloc) => bloc.add(const InspectionFormEvent.photoRemoved()),
      expect: () => [const InspectionFormState()],
    );
  });

  group('concluir inspeção', () {
    blocTest<InspectionFormBloc, InspectionFormState>(
      'recusa observação com menos de 10 caracteres',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.concluded(
          observation: 'curta',
          latitude: -7.1,
          longitude: -34.8,
        ),
      ),
      expect: () => [
        const InspectionFormState(
          message: 'A observação precisa ter pelo menos 10 caracteres.',
        ),
        const InspectionFormState(),
      ],
      verify: (_) => verifyNever(
        () => repo.createPending(
          workOrderId: any(named: 'workOrderId'),
          observation: any(named: 'observation'),
          photoPath: any(named: 'photoPath'),
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          createdBy: any(named: 'createdBy'),
        ),
      ),
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'recusa quando falta a foto',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.concluded(
          observation: observation,
          latitude: -7.1,
          longitude: -34.8,
        ),
      ),
      expect: () => [
        const InspectionFormState(
          message: 'Adicione uma foto antes de concluir.',
        ),
        const InspectionFormState(),
      ],
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'recusa quando falta a localização',
      build: buildBloc,
      seed: () => const InspectionFormState(photoPath: '/fotos/1.jpg'),
      act: (bloc) => bloc.add(
        const InspectionFormEvent.concluded(observation: observation),
      ),
      expect: () => [
        const InspectionFormState(
          photoPath: '/fotos/1.jpg',
          message: 'Confirme sua localização no mapa antes de concluir.',
        ),
        const InspectionFormState(photoPath: '/fotos/1.jpg'),
      ],
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'cria a inspeção pendente com o nome do técnico',
      setUp: () => when(
        () => repo.createPending(
          workOrderId: any(named: 'workOrderId'),
          observation: any(named: 'observation'),
          photoPath: any(named: 'photoPath'),
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          createdBy: any(named: 'createdBy'),
        ),
      ).thenAnswer((_) async => 'client-id'),
      build: buildBloc,
      seed: () => const InspectionFormState(photoPath: '/fotos/1.jpg'),
      act: (bloc) => bloc.add(
        const InspectionFormEvent.concluded(
          observation: observation,
          latitude: -7.1,
          longitude: -34.8,
        ),
      ),
      expect: () => [
        const InspectionFormState(
          status: InspectionFormStatus.submitting,
          photoPath: '/fotos/1.jpg',
        ),
        const InspectionFormState(
          status: InspectionFormStatus.success,
          photoPath: '/fotos/1.jpg',
          message: 'Inspeção concluída, adicionada à fila de sincronização.',
        ),
        const InspectionFormState(
          status: InspectionFormStatus.success,
          photoPath: '/fotos/1.jpg',
        ),
      ],
      verify: (_) => verify(
        () => repo.createPending(
          workOrderId: 'wo-1',
          observation: observation,
          photoPath: '/fotos/1.jpg',
          latitude: -7.1,
          longitude: -34.8,
          createdBy: 'Técnico Teste',
        ),
      ).called(1),
    );
  });

  group('rascunho', () {
    blocTest<InspectionFormBloc, InspectionFormState>(
      'recusa rascunho sem observação',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.draftSubmitted(observation: '   '),
      ),
      expect: () => [
        const InspectionFormState(
          message: 'Adicione ao menos uma observação antes de salvar.',
        ),
        const InspectionFormState(),
      ],
    );

    blocTest<InspectionFormBloc, InspectionFormState>(
      'salva rascunho novo mesmo sem foto e sem localização',
      setUp: () => when(
        () => repo.createDraft(
          workOrderId: any(named: 'workOrderId'),
          observation: any(named: 'observation'),
          photoPath: any(named: 'photoPath'),
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
          createdBy: any(named: 'createdBy'),
        ),
      ).thenAnswer((_) async => 'client-id'),
      build: buildBloc,
      act: (bloc) => bloc.add(
        const InspectionFormEvent.draftSubmitted(observation: 'rascunho'),
      ),
      expect: () => [
        const InspectionFormState(status: InspectionFormStatus.submitting),
        const InspectionFormState(
          status: InspectionFormStatus.success,
          message: 'Rascunho salvo localmente.',
        ),
        const InspectionFormState(status: InspectionFormStatus.success),
      ],
      verify: (_) => verify(
        () => repo.createDraft(
          workOrderId: 'wo-1',
          observation: 'rascunho',
          photoPath: null,
          latitude: null,
          longitude: null,
          createdBy: 'Técnico Teste',
        ),
      ).called(1),
    );
  });
}