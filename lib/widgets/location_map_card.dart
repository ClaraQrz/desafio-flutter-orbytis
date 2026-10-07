import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../theme/app_theme.dart';

class LocationMapCard extends StatefulWidget {
  const LocationMapCard({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.isLoading,
    required this.onRelocate,
  });

  final double? latitude;
  final double? longitude;
  final bool isLoading;
  final VoidCallback onRelocate;

  @override
  State<LocationMapCard> createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<LocationMapCard> {
  final _mapController = MapController();

  bool get _hasLocation => widget.latitude != null && widget.longitude != null;

  LatLng get _point => LatLng(widget.latitude!, widget.longitude!);

  @override
  void didUpdateWidget(covariant LocationMapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changed = oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude;
    if (changed && _hasLocation) {
      _mapController.move(_point, 16);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: SizedBox(
            height: 180,
            child: _hasLocation ? _buildMap() : _buildPlaceHolder(),
          ),
        ),
        _buildStatusBar(),
      ],
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _point,
            initialZoom: 17,
            interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom |
                InteractiveFlag.drag |
                InteractiveFlag.doubleTapZoom
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.inspecampo',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _point,
                  width: 40,
                  height: 40,
                  alignment: Alignment.topCenter,
                  child: const Icon(
                    Icons.location_on,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const RichAttributionWidget(
              attributions: [TextSourceAttribution('OpenStreetMap')],
            ),
          ],
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Material(
            color: Colors.white,
            shape: const CircleBorder(),
            elevation: 2,
            child: IconButton(
              tooltip: 'Atualizar minha localização',
              onPressed: widget.isLoading ? null : widget.onRelocate,
              icon: widget.isLoading
                  ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.my_location, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceHolder() {
    return Container(
      color: const Color(0xFFEDEBF2),
      alignment: Alignment.center,
      child: widget.isLoading
          ? const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12,),
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
            onPressed: widget.onRelocate,
            icon: const Icon(Icons.my_location),
            label: const Text('Capturar localização'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    final confirmed = _hasLocation;
    final color = confirmed ? AppColors.synced : AppColors.draft;

    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12)),
        ),
        child: Row(
            children: [
        Icon(confirmed ? Icons.check_circle : Icons.info_outline,
            color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(
          confirmed
          ? 'Localização confirmada'
              : 'Confirme sua localização para concluir',
            style: TextStyle(
                fontFamily: 'Urbanist',
                color: color,
                fontWeight: FontWeight.w600),
          ), if (confirmed)
            if (confirmed)
              Text(
                '${widget.latitude!.toStringAsFixed(4)}, '
                '${widget.longitude!.toStringAsFixed(4)}',
              style: TextStyle(fontFamily: 'Urbanist', color: color, fontSize: 12),
         ),
        ],
       ),
      ),
     ],
    ),
   );
  }
}
