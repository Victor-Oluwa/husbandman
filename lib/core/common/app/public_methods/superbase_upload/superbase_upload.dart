import 'dart:developer';
import 'dart:io';

import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/services/superbase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SuperBaseUpload {
  Future<List<String>> uploadMultipleImages(
    List<String> filePaths,
    String folderPath,
  ) async {
    try {
      final superBaseInit = SuperBaseInit();
      final downloadUrls = <String>[];

      for (final filePath in filePaths) {
        final file = File(filePath);
        final fileName = basename(file.path);
        final fullPath = '$folderPath/$fileName';

        final response = await superBaseInit.client.storage
            .from(
                'Product Images') // Ensure you have created a bucket named 'images' in your Supabase storage
            .upload(fullPath, file);

        // Get the download URL
        final downloadURL = superBaseInit.client.storage
            .from('Product Images')
            .getPublicUrl(fullPath);
        downloadUrls.add(downloadURL);
      }

      return downloadUrls;
    } catch (e) {
      throw SuperBaseException(message: e.toString(), statusCode: 500);
    }
  }
}
