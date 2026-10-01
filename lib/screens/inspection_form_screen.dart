import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../data/database.dart';
import '../data/inspection_repository.dart';
import '../models/work_order.dart';

class InspectionFormScreen extends StatefulWidget {
  final WorkOrder workOrder;
  const InspectionFormScreen({super.key, required this.workOrder});

  @override
  State<InspectionFormScreen> createState() => _InspectionFormScreenState();
}

class _InspectionFormScreenState extends State<InspectionFormScreen> {
  final _observationController = TextEditingController();
  final _repo = InspectionRepository(appDatabase);

  String? _photoPath;
  double? _latitude;
  double? _longitude;
  bool _isCapturingLocation = false;

  @override
  void dispose() {
    _observationController.dispose();
    super.dispose();
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
  if (source == null) return;

  final xfile = await ImagePicker().pickImage(source: source, imageQuality: 80);
  if (xfile == null) return;

  final docsDir = await getApplicationDocumentsDirectory();
  final photosDir = Directory(p.join(docsDir.path, 'inspection_photos'));
  if (!await photosDir.exists()) await photosDir.create(recursive: true);
  final savedPath =
      p.join(photosDir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');
  await File(xfile.path).copy(savedPath);

  setState(() => _photoPath = savedPath);
}

  Future<void> _captureLocation() async {
    setState(() => _isCapturingLocation = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw 'Ative o GPS do dispositivo.';
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Permissão de localização negada.';
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw 'Permissão negada permanentemente. Ative nas configurações do sistema.';
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _isCapturingLocation = false);
    }
  }

  Future<void> _saveDraft() async {
    if (_observationController.text.trim().isEmpty) {
      _showSnack('Adicione ao menos uma observação antes de salvar.');
      return;
    }
    await _repo.createDraft(
      workOrderId: widget.workOrder.id,
      observation: _observationController.text.trim(),
      photoPath: _photoPath,
      latitude: _latitude,
      longitude: _longitude,
    );
    if (mounted) {
      _showSnack('Rascunho salvo localmente.');
      Navigator.of(context).pop();
    }
  }

  Future<void> _concludeInspection() async {
    final observation = _observationController.text.trim();
    if (observation.length < 10) {
      _showSnack('A observação precisa ter pelo menos 10 caracteres.');
      return;
    }
    if (_photoPath == null) {
      _showSnack('Adicione uma foto antes de concluir.');
      return;
    }
    if (_latitude == null || _longitude == null) {
      _showSnack('Capture a localização antes de concluir.');
      return;
    }

    final id = await _repo.createPending(
      workOrderId: widget.workOrder.id,
      observation: observation,
      photoPath: _photoPath!,
      latitude: _latitude!,
      longitude: _longitude!,
    );

    if (mounted) {
      _showSnack('Inspeção concluída, adicionada à fila de sincronização.');
      Navigator.of(context).pop();
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final wo = widget.workOrder;
    return Scaffold(
      appBar: AppBar(title: Text(wo.code)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(wo.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Endereço: ${wo.address}'),
          const SizedBox(height: 4),
          Text('Descrição: ${wo.description}'),
          const SizedBox(height: 24),

          const Text('Observação',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _observationController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Descreva o que foi observado na inspeção...',
            ),
          ),
          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: _pickPhoto,
            icon: const Icon(Icons.camera_alt_outlined),
            label: Text(_photoPath == null ? 'Adicionar foto' : 'Trocar foto'),
          ),
          if (_photoPath != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(File(_photoPath!),
                  height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
          ],
          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: _isCapturingLocation ? null : _captureLocation,
            icon: _isCapturingLocation
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.location_on_outlined),
            label: const Text('Capturar localização'),
          ),
          if (_latitude != null && _longitude != null) ...[
            const SizedBox(height: 8),
            Text(
              'Lat: ${_latitude!.toStringAsFixed(4)} / Long: ${_longitude!.toStringAsFixed(4)}',
            ),
            const Text('✓ Localização capturada',
                style: TextStyle(color: Colors.green)),
          ],
          const SizedBox(height: 32),

          OutlinedButton(
            onPressed: _saveDraft,
            child: const Text('SALVAR RASCUNHO'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _concludeInspection,
            child: const Text('CONCLUIR INSPEÇÃO'),
          ),
        ],
      ),
    );
  }
}