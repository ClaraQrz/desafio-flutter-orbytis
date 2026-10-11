import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/database.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/history/history_bloc.dart';

import 'repositories/auth_repository.dart';
import 'repositories/inspection_repository.dart';
import 'repositories/work_orders_repository.dart';
import 'services/auth_service.dart';
import 'services/connectivity_service.dart';
import 'services/photo_service.dart';
import 'services/sync_service.dart';
import 'services/work_orders_service.dart';
import 'services/token_storage.dart';
import 'services/user_storage.dart';
import 'services/api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final connectivityService = ConnectivityService(
    checkUri: Uri.parse(ApiClient.baseUrl),
  );

  final authRepository = AuthRepository(
    authService: AuthService(),
    tokenStorage: TokenStorage(),
    userStorage: UserStorage(),
  );

  final workOrdersRepository = WorkOrdersRepository(
    workOrdersService: WorkOrdersService(),
    database: appDatabase,
    connectivity: connectivityService,
  );

  final inspectionRepository = InspectionRepository(database: appDatabase);
  final syncService = SyncService(inspectionRepository);
  final photoService = PhotoService();

  runApp(
    InspecaoCampoApp(
      authRepository: authRepository,
      workOrdersRepository: workOrdersRepository,
      inspectionRepository: inspectionRepository,
      syncService: syncService,
      photoService: photoService,
      connectivityService: connectivityService,
      appRouter: AppRouter(authRepository),
    ),
  );
}

class InspecaoCampoApp extends StatelessWidget {
  const InspecaoCampoApp({
    super.key,
    required this.authRepository,
    required this.workOrdersRepository,
    required this.inspectionRepository,
    required this.syncService,
    required this.photoService,
    required this.connectivityService,
    required this.appRouter,
  });

  final AuthRepository authRepository;
  final WorkOrdersRepository workOrdersRepository;
  final InspectionRepository inspectionRepository;
  final SyncService syncService;
  final PhotoService photoService;
  final ConnectivityService connectivityService;
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: workOrdersRepository),
        RepositoryProvider.value(value: inspectionRepository),
        RepositoryProvider.value(value: syncService),
        RepositoryProvider.value(value: photoService),
        RepositoryProvider.value(value: connectivityService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) {
              final bloc = AuthBloc(authRepository)
                ..add(const AuthEvent.started());
              ApiClient.onSessionExpired = () {
                if (!bloc.isClosed && bloc.state is AuthAuthenticated) {
                  bloc.add(const AuthEvent.sessionExpired());
                }
              };
              return bloc;
            },
          ),
          BlocProvider(
            lazy: false,
            create: (context) => HistoryBloc(
              repository: inspectionRepository,
              syncService: syncService,
              connectivity: connectivityService,
              authBloc: context.read<AuthBloc>(),
            )..add(const HistoryEvent.loadRequested()),
          ),
          BlocProvider(
            create: (_) => LoginBloc(authRepository),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous is AuthAuthenticated && current is AuthUnauthenticated,
          listener: (context, state) {
            appRouter.replaceAll([const LoginRoute()]);
          },
          child: MaterialApp.router(
            title: 'InspecCampo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            routerConfig: appRouter.config(),
          ),
        ),
      ),
    );
  }
}