import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../theme/app_theme.dart';

class LocationMapCard extends StatefulWidget {
  const LocationMapCard({
    super.key,
    required this.isLoading,
    required this.onRetry,
    this.currentLatitude,
    this.currentLongitude,
    this.confirmedLatitude,
    this.confirmedLongitude,
    this.targetLatitude,
    this.targetLongitude,
    this.route = const [],
    this.distanceMeters,
    required this.radiusMeters,
    this.isInRange = true,
    this.error,
    this.onConfirm,
    this.onExpand,
    this.fillHeight = false,
  });

  final bool isLoading;

  final VoidCallback onRetry;

  final double? currentLatitude;
  final double? currentLongitude;

  final double? confirmedLatitude;
  final double? confirmedLongitude;

  final double? targetLatitude;
  final double? targetLongitude;

  final List<LatLng> route;

  final double? distanceMeters;
  final double radiusMeters;

  final bool isInRange;

  final String? error;

  final VoidCallback? onConfirm;

  final VoidCallback? onExpand;

  final bool fillHeight;

  @override
  State<LocationMapCard> createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<LocationMapCard> {
  final _mapController = MapController();
  bool _mapReady = false;

  LatLng? _point(double? lat, double? lng) =>
      lat != null && lng != null ? LatLng(lat, lng) : null;

  LatLng? get _current =>
      _point(widget.currentLatitude, widget.currentLongitude);
  LatLng? get _confirmed =>
      _point(widget.confirmedLatitude, widget.confirmedLongitude);
  LatLng? get _target => _point(widget.targetLatitude, widget.targetLongitude);

  bool get _hasMap => _current != null || _confirmed != null || _target != null;

  bool get _locked => _confirmed != null;

  List<LatLng> _focusPoints() {
    final current = _current;
    final target = _target;
    final confirmed = _confirmed;
    return [
      ?current,
      ?target,
      if (current == null && confirmed != null) confirmed,
      ...widget.route,
    ];
  }

  CameraFit _cameraFit(List<LatLng> points) => CameraFit.bounds(
    bounds: LatLngBounds.fromPoints(points),
    padding: const EdgeInsets.all(48),
    maxZoom: 18,
  );

  void _fit() {
    final points = _focusPoints();
    if (!_mapReady || points.isEmpty) return;
    if (points.length == 1) {
      _mapController.move(points.first, 17);
    } else {
      _mapController.fitCamera(_cameraFit(points));
    }
  }

  @override
  void didUpdateWidget(covariant LocationMapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final firstFix =
        oldWidget.currentLatitude == null && widget.currentLatitude != null;
    final routeArrived = oldWidget.route.isEmpty && widget.route.isNotEmpty;
    if (!_locked && (firstFix || routeArrived)) _fit();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final map = ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: _hasMap ? _buildMap() : _buildPlaceholder(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.fillHeight)
          Expanded(child: map)
        else
          SizedBox(height: 220, child: map),
        _buildStatusBar(),
      ],
    );
  }

  Widget _buildMap() {
    final points = _focusPoints();
    final current = _current;
    final confirmed = _confirmed;
    final target = _target;

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: points.first,
            initialZoom: 17,
            initialCameraFit: points.length > 1 ? _cameraFit(points) : null,
            onMapReady: () => _mapReady = true,
            interactionOptions: InteractionOptions(
              flags: _locked
                  ? InteractiveFlag.none
                  : InteractiveFlag.pinchZoom |
                        InteractiveFlag.drag |
                        InteractiveFlag.doubleTapZoom,
            ),
            onTap: (_, _) {
              if (_locked || widget.isLoading) return;
              widget.onExpand?.call();
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.inspecampo',
            ),

            if (target != null)
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: target,
                    radius: widget.radiusMeters,
                    useRadiusInMeter: true,
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderColor: AppColors.primary,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),

            if (widget.route.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: widget.route,
                    strokeWidth: 5,
                    color: AppColors.primary.withValues(alpha: 0.85),
                    borderStrokeWidth: 1.5,
                    borderColor: Colors.white,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                if (target != null)
                  Marker(
                    point: target,
                    width: 40,
                    height: 40,
                    alignment: Alignment.topCenter,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                if (current != null)
                  Marker(
                    point: current,
                    width: 22,
                    height: 22,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 4),
                        ],
                      ),
                    ),
                  ),
                if (confirmed != null)
                  Marker(
                    point: confirmed,
                    width: 32,
                    height: 32,
                    child: const Icon(
                      Icons.check_circle,
                      size: 32,
                      color: AppColors.synced,
                    ),
                  ),
              ],
            ),
            const RichAttributionWidget(
              attributions: [TextSourceAttribution('OpenStreetMap')],
            ),
          ],
        ),
        if (widget.onExpand != null && !_locked)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Toque para ampliar',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
        if (!_locked)
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 2,
              child: IconButton(
                tooltip: 'Centralizar mapa',
                onPressed: _fit,
                icon: const Icon(Icons.my_location, color: AppColors.primary),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFEDEBF2),
      alignment: Alignment.center,
      child: widget.isLoading
          ? const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text('Obtendo localização...'),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_off_outlined, size: 32),
                const SizedBox(height: 8),
                const Text('Localização não capturada.'),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: widget.onRetry,
                  icon: const Icon(Icons.my_location),
                  label: const Text('Obter localização'),
                ),
              ],
            ),
    );
  }

  String _formatDistance(double meters) => meters < 1000
      ? '${meters.round()} m'
      : '${(meters / 1000).toStringAsFixed(1)} km';

  Widget _buildStatusBar() {
    final confirmed = _confirmed != null;
    final hasCurrent = _current != null;
    final hasTarget = _target != null;
    final distance = widget.distanceMeters;
    final radius = widget.radiusMeters.round();

    final Color color;
    final IconData icon;
    final String title;
    String? subtitle;

    if (confirmed) {
      color = AppColors.synced;
      icon = Icons.check_circle;
      title = 'Localização confirmada';
      subtitle =
          '${widget.confirmedLatitude!.toStringAsFixed(4)}, '
          '${widget.confirmedLongitude!.toStringAsFixed(4)}';
    } else if (!hasCurrent && widget.isLoading) {
      color = AppColors.draft;
      icon = Icons.gps_not_fixed;
      title = 'Obtendo sua localização...';
    } else if (!hasCurrent && widget.error != null) {
      color = AppColors.draft;
      icon = Icons.info_outline;
      title = widget.error!;
    } else if (hasCurrent && hasTarget && !widget.isInRange) {
      color = AppColors.draft;
      icon = Icons.directions;
      title = distance != null
          ? 'Você está a ${_formatDistance(distance)} do local'
          : 'Você ainda não chegou ao local';
      subtitle = 'Chegue a até $radius m para confirmar sua localização';
    } else if (hasCurrent) {
      color = AppColors.primary;
      icon = Icons.place;
      title = hasTarget ? 'Você está no local' : 'Localização obtida';
      subtitle = 'Confirme sua localização para concluir';
    } else {
      color = AppColors.draft;
      icon = Icons.info_outline;
      title = 'Confirme sua localização para concluir';
    }

    final canConfirm =
        hasCurrent &&
        widget.isInRange &&
        !confirmed &&
        widget.onConfirm != null;
    final canRetry = !hasCurrent && !widget.isLoading && widget.error != null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: color,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          if (canConfirm) ...[
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: widget.onConfirm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: const Size(0, 36),
              ),
              child: const Text('Confirmar'),
            ),
          ],
          if (canRetry) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: widget.onRetry,
              child: const Text('Tentar de novo'),
            ),
          ],
        ],
      ),
    );
  }
}