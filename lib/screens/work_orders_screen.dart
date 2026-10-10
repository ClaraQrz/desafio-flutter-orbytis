import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspecampo/blocs/auth/auth_bloc.dart';
import 'package:inspecampo/blocs/work_orders/work_orders_bloc.dart';
import '../models/work_order.dart';
import '../repositories/work_orders_repository.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';
import '../repositories/inspection_repository.dart';

IconData _iconForWorkOrderStatus(String status) => switch (status) {
  'done' => Icons.check_circle,
  'in_progress' => Icons.schedule,
  _ => Icons.description_outlined,
};

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

  Future<void> _openWorkOrder(BuildContext context, WorkOrder workOrder) async {
    final draft = await context
        .read<InspectionRepository>()
        .getDraftFor(workOrder.id);
    if (!context.mounted) return;

    await context.router.push(
      InspectionFormRoute(workOrder: workOrder, draft: draft),
    );
    if (context.mounted) _refresh(context);
  }

  /// Abre o histórico e, ao voltar, recarrega a lista (uma OS pode ter sido
  /// concluída lá).
  Future<void> _openHistory(BuildContext context) async {
    await context.router.push(const HistoryRoute());
    if (context.mounted) _refresh(context);
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
          decoration: const BoxDecoration(gradient: AppGradient.grad),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                const _Header(),
                Expanded(
                  child: BlocBuilder<WorkOrdersBloc, WorkOrdersState>(
                    builder: (context, state) {
                      return switch (state) {
                        WorkOrdersLoading() => const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),

                        WorkOrdersEmpty() => _RefreshableList(
                          onRefresh: () => _refresh(context),
                          children: const [
                            SizedBox(height: 120),
                            Center(
                              child: Text(
                                'Nenhuma OS no momento.',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),

                        WorkOrdersFailure(
                          :final message,
                          :final isSessionExpired,
                        ) =>
                          _RefreshableList(
                            onRefresh: () => _refresh(context),
                            children: [
                              const SizedBox(height: 100),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: 200,
                                        child: isSessionExpired
                                            ? FilledButton.icon(
                                                style: _errorButtonStyle,
                                                onPressed: () =>
                                                    _sessionExpired(context),
                                                icon: const Icon(Icons.login),
                                                label: const Text(
                                                  'Fazer login',
                                                ),
                                              )
                                            : FilledButton.icon(
                                                style: _errorButtonStyle,
                                                onPressed: () =>
                                                    _reload(context),
                                                icon: const Icon(Icons.refresh),
                                                label: const Text(
                                                  'Tentar novamente',
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        WorkOrdersLoaded(:final workOrders) ||
                        WorkOrdersRefreshing(
                          :final workOrders,
                        ) => RefreshIndicator(
                          onRefresh: () => _refresh(context),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            itemCount: workOrders.length,
                            itemBuilder: (context, index) {
                              final workOrder = workOrders[index];
                              return _WorkOrderCard(
                                workOrder: workOrder,
                                onTap: () => _openWorkOrder(context, workOrder),
                              );
                            },
                          ),
                        ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: AppColors.navBar,
            indicatorColor: AppColors.navIndicator,
            indicatorShape: const StadiumBorder(),
            labelTextStyle: const WidgetStatePropertyAll(
              TextStyle(
                fontFamily: 'Urbanist',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            iconTheme: const WidgetStatePropertyAll(
              IconThemeData(color: Colors.white),
            ),
          ),
          child: NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (i) {
              switch (i) {
                case 1:
                  _openHistory(context);
                case 2:
                  _logout(context);
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Início',
              ),
              NavigationDestination(
                icon: Icon(Icons.history),
                label: 'Histórico',
              ),
              NavigationDestination(icon: Icon(Icons.logout), label: 'Sair'),
            ],
          ),
        ),
      ),
    );
  }
}

final _errorButtonStyle = FilledButton.styleFrom(
  backgroundColor: Colors.white,
  foregroundColor: AppColors.primary,
);

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Inspe',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: 'Campo',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final name = state is AuthAuthenticated ? state.user.name : null;

              return Text(
                name != null ? 'Olá, $name' : 'Ordens de serviço',
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24,
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          const Text(
            'Aqui estão suas ordens de serviço',
            style: TextStyle(
              fontFamily: 'Urbanist',
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkOrderCard extends StatelessWidget {
  final WorkOrder workOrder;
  final VoidCallback onTap;

  const _WorkOrderCard({required this.workOrder, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            workOrder.code,
                            style: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _StatusChip(status: workOrder.status),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      workOrder.title,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Icons.location_on, text: workOrder.address),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 13,
              color: Colors.black54,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = colorForWorkOrderStatus(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            labelForWorkOrderStatus(status),
            style: TextStyle(
              color: color,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 4),
          Icon(_iconForWorkOrderStatus(status), size: 14, color: color),
        ],
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