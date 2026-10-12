import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/utils.dart';

class DocumentFileService {
  DocumentFileService._();
  static final DocumentFileService instance = DocumentFileService._();

  FutureEither<File?> pickDocument() {
    return runTask(() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
      );
      final path = result?.files.single.path;
      if (path == null) return null;
      return File(path);
    });
  }

  FutureEither<File> saveToFileManager(File source,
      {required String fileName}) {
    return runTask(() async {
      final directory = await _downloadDirectory();
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final extension = _extension(source.path);
      final cleanName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_');
      final output = File('${directory.path}${Platform.pathSeparator}'
          '$cleanName$extension');
      return source.copy(output.path);
    });
  }

  Future<Directory> _downloadDirectory() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isPermanentlyDenied) await openAppSettings();
      return Directory('/storage/emulated/0/Download');
    }
    if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    }
    return await getDownloadsDirectory() ??
        await getApplicationDocumentsDirectory();
  }

  String _extension(String path) {
    final lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    final fileName =
        lastSeparator >= 0 ? path.substring(lastSeparator + 1) : path;
    final dot = fileName.lastIndexOf('.');
    if (dot <= 0) return '.pdf';
    return fileName.substring(dot);
  }
}
