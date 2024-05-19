import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:husbandman/core/error/exceptions.dart';

class FileCompressor {
  Future<List<Uint8List?>> compressFile(List<File> files) async {
    final allBytes = <Uint8List?>[];

    try {
      for (final file in files) {
        // Determine the file extension of the original file
        final fileExtension = file.path
            .split('.')
            .last
            .toLowerCase();
        // Check if the file is a JPEG and set the correct extension for the compressed file
        final compressedExtension = (fileExtension == 'jpg' ||
            fileExtension == 'jpeg') ? fileExtension : 'jpg';
        // Generate a new file path for the compressed file with the correct extension
        final compressedFilePath = '${file.absolute
            .path}_compressed.$compressedExtension';

        final result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          compressedFilePath, // Use the new file path for the compressed file
          quality: 88, // Adjust quality as needed
        );
        final bytes = await result?.readAsBytes();
        allBytes.add(bytes);
        bytes!.clear();
      }
    } catch (e) {
      throw CompressorException(message: e.toString(), statusCode: 500);
    }
    return allBytes;
  }
}

