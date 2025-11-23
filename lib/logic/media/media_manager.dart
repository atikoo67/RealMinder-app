import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class MediaManager {
  static Future<String> copyToAppDirectory(String sourcePath) async {
    try {
      final File sourceFile = File(sourcePath);
      final String fileName = path.basename(sourcePath);

      final Directory appDir = await getApplicationDocumentsDirectory();
      final String appMediaPath = path.join(appDir.path, 'media');

      await Directory(appMediaPath).create(recursive: true);

      final String destPath = path.join(appMediaPath, fileName);

      await sourceFile.copy(destPath);

      return destPath;
    } catch (e) {
      throw Exception('Failed to copy file: $e');
    }
  }

  static Future<String?> selectAndSaveImage(XFile? pickedFile) async {
    try {
      if (pickedFile != null) {
        final String newPath = await copyToAppDirectory(pickedFile.path);
        return newPath;
      }
      return null;
    } catch (e) {
      print('Error selecting image: $e');
      return null;
    }
  }

  static Future<String?> selectAndSaveVideo(XFile? pickedFile) async {
    try {
      if (pickedFile != null) {
        final String newPath = await copyToAppDirectory(pickedFile.path);
        return newPath;
      }
      return null;
    } catch (e) {
      print('Error selecting video: $e');
      return null;
    }
  }
}
