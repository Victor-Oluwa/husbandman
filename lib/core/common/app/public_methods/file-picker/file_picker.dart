import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:husbandman/core/error/exceptions.dart';

class PickFile {
   Future<List<File>> pickMultiple() async {
    final images = <File>[];
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        compressionQuality: 8
      );

      if (result != null && result.files.isNotEmpty) {
        final length = result.files.length <= 5 ? result.files.length : 5;
        for (var i = 0; i < length; i++) {
          images.add(File(result.files[i].path!));
        }
      }
    } catch (e) {
      throw FilePickerException(message: e.toString(), statusCode: 500);
    }
    return images;
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
