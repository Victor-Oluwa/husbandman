import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';

class CloudinaryUpload {
  Future<List<String>> uploadMultipleFile({
    required List<Uint8List?> compressedFile,
  }) async {
    try {
      final uploadedUrls = <String>[];
      for (final data in compressedFile) {
        if (data == null) {
          throw const CloudinaryException(
            message: 'Compressed file is null',
            statusCode: 404,
          );
        }
        final url = Uri.parse(
          '$kCloudinaryBaseUrl$kCloudinaryCloudName$kCloudinaryEndpoint',
        );

        final request = http.MultipartRequest('POST', url)
          ..fields['upload-preset'] = kCloudinaryUploadPreset
          ..fields['api_key'] = kCloudinaryApiKey
          ..fields['timestamp'] =
              DateTime.now().millisecondsSinceEpoch.toString()
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              data,
              filename: '${DateTime.now().microsecondsSinceEpoch}.jpg',
            ),
          );

        final response = await request.send();
        if (response.statusCode != 200 && response.statusCode != 201) {
          throw CloudinaryException(
            message: response.stream.toString(),
            statusCode: response.statusCode,
          );
        }

        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString) as DataMap;

        final fileUrl = jsonMap['url'] as String;

        uploadedUrls.add(fileUrl);
      }
      return uploadedUrls;
    } catch (e) {
      throw CloudinaryException(message: e.toString(), statusCode: 500);
    }
  }
}
