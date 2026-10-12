import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/utils.dart';

/// A service to handle media selection (images, videos, files).
class MediaService {
  MediaService._();
  static final MediaService instance = MediaService._();

  final ImagePicker _imagePicker = ImagePicker();

  /// Pick an image from gallery or camera.
  FutureEither<File?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    return runTask(() async {
      if (source == ImageSource.camera) {
        await _ensureCameraPermission();
      } else if (!Platform.isIOS) {
        await _ensureGalleryPermission();
      }

      final XFile? file = await _imagePicker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      return file != null ? File(file.path) : null;
    });
  }

  Future<void> _ensureCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isPermanentlyDenied) {
      throw Exception(
        'Camera permission is disabled. Please enable it from app settings.',
      );
    }
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isPermanentlyDenied) {
      throw Exception(
        'Camera permission is disabled. Please enable it from app settings.',
      );
    }
    if (!status.isGranted) {
      throw Exception('Camera permission is required to take a photo.');
    }
  }

  Future<void> _ensureGalleryPermission() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isPermanentlyDenied) {
        throw Exception(
          'Photo library permission is disabled. Please enable it from app settings.',
        );
      }
      if (!status.isGranted && !status.isLimited) {
        status = await Permission.photos.request();
      }
      if (status.isPermanentlyDenied) {
        throw Exception(
          'Photo library permission is disabled. Please enable it from app settings.',
        );
      }
      if (!status.isGranted && !status.isLimited) {
        throw Exception('Photo library permission is required.');
      }
      return;
    }

    if (Platform.isAndroid) {
      var photosStatus = await Permission.photos.status;
      if (photosStatus.isPermanentlyDenied) {
        throw Exception(
          'Photo permission is disabled. Please enable it from app settings.',
        );
      }
      if (!photosStatus.isGranted && !photosStatus.isLimited) {
        photosStatus = await Permission.photos.request();
      }
      if (photosStatus.isGranted || photosStatus.isLimited) return;

      var storageStatus = await Permission.storage.status;
      if (storageStatus.isPermanentlyDenied) {
        throw Exception(
          'Photo permission is disabled. Please enable it from app settings.',
        );
      }
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.storage.request();
      }
      if (photosStatus.isPermanentlyDenied ||
          storageStatus.isPermanentlyDenied) {
        throw Exception(
          'Photo permission is disabled. Please enable it from app settings.',
        );
      }
      if (!storageStatus.isGranted) {
        throw Exception('Photo permission is required.');
      }
    }
  }

  /// Pick multiple images from gallery.
  FutureEither<List<File>> pickMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    return runTask(() async {
      final List<XFile> files = await _imagePicker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      return files.map((file) => File(file.path)).toList();
    });
  }

  /// Pick a video from gallery or camera.
  FutureEither<File?> pickVideo({
    required ImageSource source,
    Duration? maxDuration,
  }) async {
    return runTask(() async {
      if (source == ImageSource.camera) {
        var status = await Permission.camera.status;
        if (status.isPermanentlyDenied) {
          throw Exception(
            'Camera permission is disabled. Please enable it from app settings.',
          );
        }
        if (!status.isGranted) {
          status = await Permission.camera.request();
        }
        if (status.isPermanentlyDenied) {
          throw Exception(
              'Camera permission is disabled. Please enable it from app settings.');
        } else if (!status.isGranted && !status.isLimited) {
          throw Exception('Camera permission denied');
        }
      }

      final XFile? file = await _imagePicker.pickVideo(
        source: source,
        maxDuration: maxDuration,
      );

      return file != null ? File(file.path) : null;
    });
  }

  /// Pick one or more files from the device.
  FutureEither<List<File>> pickFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    return runTask(() async {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );

      if (result == null || result.files.isEmpty) return [];

      return result.paths
          .where((path) => path != null)
          .map((path) => File(path!))
          .toList();
    });
  }
}
