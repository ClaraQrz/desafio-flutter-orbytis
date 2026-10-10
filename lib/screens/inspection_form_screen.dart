import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/inspection_form/inspection_form_bloc.dart';
import '../blocs/location/location_bloc.dart';
import '../data/database.dart';
import '../models/work_order.dart';
import '../repositories/inspection_repository.dart';
import '../services/route_service.dart';
import '../theme/app_theme.dart';
import '../widgets/location_map_card.dart';

@RoutePage()
class InspectionFormScreen extends StatefulWidget implements AutoRouteWrapper {
  final WorkOrder workOrder;

  final Inspection? draft;

  final bool readOnly;

  const InspectionFormScreen({
    super.key,
    required this.workOrder,
    this.draft,
    this.readOnly = false,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final userName = authState is AuthAuthenticated
        ? authState.user.name
        : null;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final hasLocation =
                draft?.latitude != null && draft?.longitude != null;
            final bloc = LocationBloc(
              routeService: RouteService(),
              targetLatitude: workOrder.latitude,
              targetLongitude: workOrder.longitude,
              initialLatitude: draft?.latitude,
              initialLongitude: draft?.longitude,
            );
            if (!hasLocation && !readOnly) bloc.add(const LocationRequested());
            return bloc;
          },
        ),
        BlocProvider(
          create: (_) => InspectionFormBloc(
            InspectionRepository(database: appDatabase, createdBy: userName),
            workOrderId: workOrder.id,
            draft: draft,
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  State<InspectionFormScreen> createState() => _InspectionFormScreenState();
}

class _InspectionFormScreenState extends State<InspectionFormScreen> {
  late final TextEditingController _observationController;

  bool get _readOnly => widget.readOnly;

  @override
  void initState() {
    super.initState();
    _observationController = TextEditingController(
      text: widget.draft?.observation,
    );
  }

  @override
  void dispose() {
    _observationController.dispose();
    super.dispose();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _openPhoto(String path) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => _PhotoViewerPage(path: path)));
  }

  void _openMapFullscreen() {
    final bloc = context.read<LocationBloc>();
    final wo = widget.workOrder;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: _FullScreenMapPage(workOrder: wo),
        ),
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Tirar foto'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Escolher da galeria'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;
    context.read<InspectionFormBloc>().add(PhotoSourceSelected(source));
  }

  void _saveDraft() {
    final loc = context.read<LocationBloc>().state;
    context.read<InspectionFormBloc>().add(
      DraftSubmitted(
        observation: _observationController.text,
        latitude: loc.latitude,
        longitude: loc.longitude,
      ),
    );
  }

  void _concludeInspection() {
    final loc = context.read<LocationBloc>().state;
    context.read<InspectionFormBloc>().add(
      InspectionConcluded(
        observation: _observationController.text,
        latitude: loc.latitude,
        longitude: loc.longitude,
      ),
    );
  }

  (String, IconData, Color) _statusChip(String status) {
    switch (status) {
      case 'done':
        return ('CONCLUÍDA', Icons.check_circle, AppColors.synced);
      case 'in_progress':
        return ('EM ANDAMENTO', Icons.timelapse, AppColors.primary);
      default:
        return ('PENDENTE', Icons.schedule, AppColors.primary);
    }
  }

  String get _title {
    if (_readOnly) return 'Inspeção';
    return widget.draft == null ? 'Ordem de Serviço' : 'Editar rascunho';
  }

  @override
  Widget build(BuildContext context) {
    final wo = widget.workOrder;
    final inspection = widget.draft;
    final (chipText, chipIcon, chipColor) = _statusChip(wo.status);

    return MultiBlocListener(
      listeners: [
        BlocListener<InspectionFormBloc, InspectionFormState>(
          listenWhen: (prev, curr) =>
              curr.message != null || (curr.isSuccess && !prev.isSuccess),
          listener: (context, state) {
            if (state.message != null) _showSnack(state.message!);
            if (state.isSuccess) Navigator.of(context).pop();
          },
        ),
        BlocListener<LocationBloc, LocationState>(
          listenWhen: (prev, curr) =>
              curr.status == LocationStatus.failure &&
              prev.status != LocationStatus.failure,
          listener: (context, state) =>
              _showSnack(state.error ?? 'Erro ao obter localização.'),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            _title,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    _readOnly ? 24 + MediaQuery.paddingOf(context).bottom : 24,
                  ),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'OS #${wo.code}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _StatusChip(
                          text: chipText,
                          icon: chipIcon,
                          color: chipColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      wo.title,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(child: Text(wo.address)),
                      ],
                    ),

                    if (wo.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const _SectionLabel('Descrição'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F0F6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          wo.description,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],

                    if (_readOnly && inspection != null) ...[
                      const SizedBox(height: 20),
                      const _SectionLabel('Inspeção'),
                      const SizedBox(height: 8),
                      _InspectionInfo(inspection: inspection),
                    ],

                    const SizedBox(height: 20),
                    const _SectionLabel('Observação'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _observationController,
                      readOnly: _readOnly,
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: _readOnly
                            ? 'Sem observação.'
                            : 'Digite uma observação...',
                        hintStyle: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const _SectionLabel('Registro fotográfico'),
                    const SizedBox(height: 8),
                    BlocBuilder<InspectionFormBloc, InspectionFormState>(
                      buildWhen: (prev, curr) =>
                          prev.photoPath != curr.photoPath ||
                          prev.status != curr.status,
                      builder: (context, state) {
                        final busy =
                            state.status == InspectionFormStatus.pickingPhoto;
                        if (state.photoPath == null) {
                          if (_readOnly) {
                            return const Text(
                              'Sem foto.',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                color: Colors.black54,
                              ),
                            );
                          }
                          return _AddPhotoBox(
                            busy: busy,
                            onTap: busy ? null : _pickPhoto,
                          );
                        }
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: _PhotoThumb(
                            path: state.photoPath!,
                            onTap: busy
                                ? null
                                : () => _openPhoto(state.photoPath!),
                            onRemove: _readOnly
                                ? null
                                : () => context.read<InspectionFormBloc>().add(
                                    const PhotoRemoved(),
                                  ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    const _SectionLabel('Localização'),
                    const SizedBox(height: 8),
                    if (_readOnly)
                      _ReadOnlyLocation(
                        latitude: inspection?.latitude,
                        longitude: inspection?.longitude,
                      )
                    else
                      BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) => _buildMapCard(
                          context,
                          state,
                          wo,
                          onExpand: _openMapFullscreen,
                        ),
                      ),
                  ],
                ),
              ),

              if (!_readOnly)
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    child: BlocBuilder<InspectionFormBloc, InspectionFormState>(
                      buildWhen: (prev, curr) =>
                          prev.isSubmitting != curr.isSubmitting,
                      builder: (context, state) {
                        final submitting = state.isSubmitting;
                        return Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: submitting ? null : _saveDraft,
                                child: const Text('Salvar rascunho'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: submitting
                                    ? null
                                    : _concludeInspection,
                                child: submitting
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Concluir inspeção'),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final local = date.toLocal();
  return '${local.day.toString().padLeft(2, '0')}/'
      '${local.month.toString().padLeft(2, '0')}/${local.year} '
      '${local.hour.toString().padLeft(2, '0')}:'
      '${local.minute.toString().padLeft(2, '0')}';
}

IconData _iconForSyncStatus(String status) => switch (status) {
  'synced' => Icons.check_circle,
  'pending' => Icons.schedule,
  'failed' => Icons.error_outline,
  _ => Icons.edit_outlined,
};

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.text,
    required this.icon,
    required this.color,
  });

  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Icon(icon, size: 16, color: color),
        ],
      ),
    );
  }
}

class _InspectionInfo extends StatelessWidget {
  const _InspectionInfo({required this.inspection});

  final Inspection inspection;

  @override
  Widget build(BuildContext context) {
    final color = colorForSyncStatus(inspection.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatusChip(
            text: labelForSyncStatus(inspection.status).toUpperCase(),
            icon: _iconForSyncStatus(inspection.status),
            color: color,
          ),
          _InfoLine(label: 'Data/hora', value: _formatDate(inspection.capturedAt)),
          if (inspection.createdBy != null)
            _InfoLine(label: 'Técnico', value: inspection.createdBy!),
          if (inspection.status == 'failed' &&
              inspection.errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              inspection.errorMessage!,
              style: const TextStyle(
                fontFamily: 'Urbanist',
                color: AppColors.failed,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
          ],
        ),
        style: const TextStyle(fontFamily: 'Urbanist', fontSize: 14),
      ),
    );
  }
}

class _ReadOnlyLocation extends StatelessWidget {
  const _ReadOnlyLocation({required this.latitude, required this.longitude});

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    final hasLocation = latitude != null && longitude != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.my_location, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hasLocation
                  ? 'Lat ${latitude!.toStringAsFixed(6)}, '
                        'Lng ${longitude!.toStringAsFixed(6)}'
                  : 'Localização não registrada.',
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPhotoBox extends StatelessWidget {
  const _AddPhotoBox({required this.busy, required this.onTap});

  final bool busy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: CustomPaint(
        painter: _DashedRRectPainter(color: AppColors.primary),
        child: SizedBox(
          height: 110,
          width: double.infinity,
          child: Center(
            child: busy
                ? const CircularProgressIndicator(strokeWidth: 2)
                : const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Adicionar imagem',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Câmera ou galeria',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({
    required this.path,
    required this.onTap,
    required this.onRemove,
  });

  final String path;
  final VoidCallback? onTap;

  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(path),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              cacheWidth: 360,
              errorBuilder: (_, _, _) => Container(
                width: 120,
                height: 120,
                color: const Color(0xFFF1F0F6),
                child: const Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
        ),
        if (onRemove != null)
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      );
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 6), paint);
        distance += 10;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) => old.color != color;
}

Widget _buildMapCard(
  BuildContext context,
  LocationState state,
  WorkOrder wo, {
  VoidCallback? onExpand,
  bool fillHeight = false,
}) {
  final bloc = context.read<LocationBloc>();
  return LocationMapCard(
    isLoading: state.isLoading,
    error: state.error,
    currentLatitude: state.currentLatitude,
    currentLongitude: state.currentLongitude,
    confirmedLatitude: state.latitude,
    confirmedLongitude: state.longitude,
    targetLatitude: wo.latitude,
    targetLongitude: wo.longitude,
    route: state.route,
    distanceMeters: state.distanceMeters,
    radiusMeters: bloc.radiusMeters,
    isInRange: state.isInRange,
    isManual: state.isManual,
    onRetry: () => bloc.add(const LocationRequested()),
    onConfirm: () => bloc.add(const LocationConfirmed()),
    onExpand: onExpand,
    fillHeight: fillHeight,
  );
}

class _FullScreenMapPage extends StatelessWidget {
  const _FullScreenMapPage({required this.workOrder});

  final WorkOrder workOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Localização',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) =>
              _buildMapCard(context, state, workOrder, fillHeight: true),
        ),
      ),
    );
  }
}

class _PhotoViewerPage extends StatelessWidget {
  const _PhotoViewerPage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Image.file(
            File(path),
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Text(
              'Não foi possível abrir a imagem.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}