import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspecampo/blocs/auth/auth_bloc.dart';
import 'package:inspecampo/blocs/work_orders/work_orders_bloc.dart';
import '../models/user.dart';
import '../models/work_order.dart';
import '../repositories/work_orders_repository.dart';
import '../router/app_router.dart';
import '../services/token_storage.dart';
import '../services/user_storage.dart';
import '../services/work_orders_service.dart';
import '../theme/app_theme.dart';
import 'inspection_form_screen.dart';
import 'history_screen.dart';
import 'package:auto_route/auto_route.dart';


@RoutePage()
class WorkOrdersScreen extends StatelessWidget implements AutoRouteWrapper {
  const WorkOrdersScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      WorkOrdersBloc(context.read<WorkOrdersRepository>())
        ..add(const WorkOrdersEvent.loadRequested()),
      child: this,
    );
  }

  Future<void> _refresh(BuildContext context) {
    return context.read<WorkOrdersBloc>().refresh();
  }

  void _reload(BuildContext context) {
    context.read<WorkOrdersBloc>().add(.loadRequested());
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(.logoutRequested());
  }

  void _sessionExpired(BuildContext context) {
    context.read<AuthBloc>().add(.sessionExpired());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (_, current) => current is AuthUnauthenticated,
      listener: (context, _) {
        context.router.replaceAll([const LoginRoute()]);
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppGradient.main),
          child: SafeArea(bottom: false,
              child: Column(
                children: [
                  _Header(OnSync: () => _reload(context)),
                  Expanded(child: BlocBuilder<WorkOrdersBloc, WorkOrdersState>(
                    builder: (context, state) {
                      return switch (state) {
                        WorkOrdersLoading() =>
                            Center(child: CircularProgressIndicator(
                              color: Colors.white,),
                            ),
                        WorkOrdersEmpty() =>
                            _RefreshableList(onRefresh: () => _refresh(context),
                              children: [ SizedBox(height: 120),
                                Center(child: Text('Nenhuma OS no momento. ',
                                  style: TextStyle(color: Colors.white70),
),
),
                              ],)
                    },
                  )
                  )
                ],
              )),
        )


        appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState > (
      builder: (context, state) {
        final name = state is AuthAuthenticated ? state.user.name : null;

        return Text(name != null ? 'Olá, $name' : 'Ordens de serviço');
      },
      ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.router.push(const HistoryRoute()),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: BlocBuilder<WorkOrdersBloc, WorkOrdersState>(
        builder: (context, state) {
          return switch (state) {
            WorkOrdersLoading() =>
            const Center(
              child: CircularProgressIndicator(),
            ),

            WorkOrdersEmpty() =>
                _RefreshableList(
                  onRefresh: () => _refresh(context),
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('Nenhuma OS no momento.')),
                  ],
                ),
            WorkOrdersFailure(:final message, :final isSessionExpired) =>
                _RefreshableList(
                  onRefresh: () => _refresh(context),
                  children: [
                    const SizedBox(height: 100),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 200,
                              child: isSessionExpired
                                  ? OutlinedButton.icon(
                                onPressed: () => _sessionExpired(context),
                                icon: const Icon(Icons.login),
                                label: const Text('Fazer login'),
                              )
                                  : OutlinedButton.icon(
                                onPressed: () => _reload(context),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Tentar novamente'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            WorkOrdersLoaded(:final WorkOrders) =>
                RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: WorkOrders.length,
                    itemBuilder: (context, index) {
                      final workOrder = WorkOrders[index];
                      return InkWell(
                        onTap: () =>
                            context.router.push(
                              InspectionFormRoute(workOrder: workOrder),
                            ),
                        child: _WorkOrderCard(workOrder: workOrder),
                      );
                    },
                  ),
                ),
          };
        },
      ),
    ),);
  }
}

class _WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;

  const _WorkOrderCard({required this.workOrder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workOrder.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _RefreshableList extends StatelessWidget {
  const _RefreshableList({required this.onRefresh, required this.children});

  final Future<void> Function() onRefresh;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: children,
      ),
    );
  }
}