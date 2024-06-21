import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:husbandman/core/error/exceptions.dart';

class PickFile {
  Future<List<String>> pickMultiple() async {
    final images = <File>[];
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        return result.paths.map((path) => path!).toList();
      } else {
        throw const FilePickerException(
          message: 'No file was picked',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw FilePickerException(message: e.toString(), statusCode: 500);
    }
  }

// static Future<List<File>> pickSingle() async {
//   final images = <File>[];
//   try {
//     final files = await FilePicker.platform.pickFiles();
//
//     if (files != null && files.files.isNotEmpty) {
//       for (var i = 0; i < files.files.length; i++) {
//         images.add(File(files.files[i].path!));
//       }
//     }
//   } catch (e) {
//     debugPrint(e.toString());
//   }
//   return images;
// }
}
