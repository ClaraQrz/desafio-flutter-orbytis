import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

enum PhotoSource { camera, gallery }

class PhotoService {
  PhotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> pick(PhotoSource source) async {
    final xfile = await _picker.pickImage(
      source: switch (source) {
        PhotoSource.camera => ImageSource.camera,
        PhotoSource.gallery => ImageSource.gallery,
      },
      imageQuality: 80,
    );
    if (xfile == null) return null;

    final docsDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(p.join(docsDir.path, 'inspection_photos'));
    if (!await photosDir.exists()) await photosDir.create(recursive: true);

    final savedPath = p.join(
      photosDir.path,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await File(xfile.path).copy(savedPath);
    return savedPath;
  }
}