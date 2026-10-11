import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/history/history_bloc.dart';
import '../data/database.dart';
import '../models/inspection_status.dart';
import '../repositories/work_orders_repository.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget implements AutoRouteWrapper {
  const HistoryScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<HistoryBloc>().add(const HistoryEvent.loadRequested());
    return this;
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _openInspection(
    BuildContext context,
    Inspection inspection,
  ) async {
    final readOnly = inspection.status != InspectionStatus.draft.value;

    final workOrder = await context
        .read<WorkOrdersRepository>()
        .getCachedWorkOrder(inspection.workOrderId);
    if (!context.mounted) return;

    if (workOrder == null) {
      _showSnack(
        context,
        'Não foi possível abrir: a OS ${inspection.workOrderId} '
        'não está salva no aparelho.',
      );
      return;
    }

    await context.router.push(
      InspectionFormRoute(
        workOrder: workOrder,
        draft: inspection,
        readOnly: readOnly,
      ),
    );

    if (context.mounted) {
      context.read<HistoryBloc>().add(const HistoryEvent.loadRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listenWhen: (_, current) => current.message != null,
      listener: (context, state) => _showSnack(context, state.message!),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Histórico',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            BlocBuilder<HistoryBloc, HistoryState>(
              buildWhen: (prev, curr) => prev.isSyncing != curr.isSyncing,
              builder: (context, state) => IconButton(
                icon: state.isSyncing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.sync),
                onPressed: state.isSyncing
                    ? null
                    : () => context.read<HistoryBloc>().add(
                        const HistoryEvent.syncRequested(),
                      ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const _FilterChips(),
            Expanded(
              child: _InspectionList(
                onOpen: (inspection) => _openInspection(context, inspection),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (prev, curr) => prev.filter != curr.filter,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: HistoryFilter.values.map((filter) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(filter.label),
                  selected: state.filter == filter,
                  onSelected: (_) => context.read<HistoryBloc>().add(
                    HistoryEvent.filterChanged(filter),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _InspectionList extends StatelessWidget {
  const _InspectionList({required this.onOpen});

  final void Function(Inspection inspection) onOpen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (prev, curr) =>
          prev.isLoading != curr.isLoading ||
          prev.inspections != curr.inspections ||
          prev.filter != curr.filter,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        final items = state.filtered;
        if (items.isEmpty) {
          return const Center(
            child: Text(
              'Nenhuma inspeção neste filtro.',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<HistoryBloc>().reload(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final inspection = items[index];
              return _InspectionCard(
                inspection: inspection,
                onTap: () => onOpen(inspection),
                onRetry: inspection.status == InspectionStatus.failed.value
                    ? () => context.read<HistoryBloc>().add(
                        HistoryEvent.retryRequested(inspection),
                      )
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}

class _InspectionCard extends StatelessWidget {
  final Inspection inspection;
  final VoidCallback? onRetry;
  final VoidCallback onTap;

  const _InspectionCard({
    required this.inspection,
    required this.onTap,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDraft = inspection.status == InspectionStatus.draft.value;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
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
                    Text(
                      'OS #${inspection.workOrderId}',
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Data/hora: ${_formatDate(inspection.capturedAt)}',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    if (inspection.createdBy != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Técnico: ${inspection.createdBy}',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorForSyncStatus(
                          inspection.status,
                        ).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        labelForSyncStatus(inspection.status),
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: colorForSyncStatus(inspection.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    if (inspection.status == InspectionStatus.failed.value &&
                        inspection.errorMessage != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        inspection.errorMessage!,
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          color: AppColors.failed,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onRetry != null)
                TextButton(
                  onPressed: onRetry,
                  child: const Text('Tentar novamente'),
                ),
              Icon(
                isDraft ? Icons.edit_outlined : Icons.chevron_right,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day.toString().padLeft(2, '0')}/'
        '${local.month.toString().padLeft(2, '0')}/${local.year} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}
