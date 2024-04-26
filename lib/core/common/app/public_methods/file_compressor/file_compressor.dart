import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:husbandman/core/error/exceptions.dart';

class FileCompressor{
  static Future<List<Uint8List?>> compressFile(List<File> files)async{
    final allBytes = <Uint8List?>[];

    try{
      for(final file in files){
        final result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          file.absolute.path,
          quality: 88, // Adjust quality as needed
        );
        final bytes = await result?.readAsBytes();
        allBytes.add(bytes);
      }
    } catch(e){
      throw CompressorException(message: e.toString(), statusCode: 500);
    }

    return allBytes;
  }
}
