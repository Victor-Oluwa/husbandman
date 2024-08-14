import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloudinary/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';

class CloudinaryUpload {
  final cloudinary = Cloudinary.unsignedConfig(
    cloudName: kCloudinaryCloudName,
  );

  Future<List<String>> uploadImage({
    required List<Uint8List?>? compressedFile,
    required String sellerName,
  }) async {
    try{
      final response = await cloudinary.unsignedUpload(
        uploadPreset: kCloudinaryUploadPreset,
        fileBytes: compressedFile![0],
        folder: sellerName,
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {
          log('Uploading image from file with progress: $count/$total');
        },
      );
      if (!response.isSuccessful || response.secureUrl == null) {
        throw CloudinaryException(
          message: response.error ?? 'Cloudinary upload failed',
          statusCode: response.statusCode ?? 500,
        );
      }
        return [response.secureUrl!];
    } catch(e){
      throw CloudinaryException(message: e.toString(), statusCode: 500);
    }

  }

  Future<List<String>> uploadImageAsFile({
    required List<File>? file,
    required String sellerName,
  }) async {
    final client = http.Client();
    try {
      final uploadedUrls = <String>[];

      for (final data in file ?? []) {
        final file = data as File;
        final url = Uri.parse(
          '$kCloudinaryBaseUrl$kCloudinaryCloudName$kCloudinaryEndpoint',
        );

        final request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = kCloudinaryUploadPreset
          ..fields['api_key'] = kCloudinaryApiKey
          ..fields['timestamp'] =
          DateTime.now().millisecondsSinceEpoch.toString()
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
              filename: '${DateTime.now().microsecondsSinceEpoch}.jpg',
            ),
          );

        final response = await client.send(request);
        // final response = await request.send();

        if (response.statusCode != 200 && response.statusCode != 201) {
          // Read the response stream and parse it as JSON
          final responseData = await response.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);

          // Log the detailed error message
          log('Error uploading file to Cloudinary: $jsonMap');

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
    } finally {
      client.close();
    }
  }

  Future<void> deleteImage({
    required String url,
  }) async {
    final response = await cloudinary.destroy(
      'public_id',
      url: url,
      resourceType: CloudinaryResourceType.image,
      invalidate: false,
    );

    if (response.isSuccessful) {
     //Do something else
    }
  }

// Future<List<String>> uploadImageAsFile({
//   required List<File>? file,
//   required String sellerName,
// }) async {
//   final response = await cloudinary.unsignedUpload(
//     uploadPreset: kCloudinaryUploadPreset,
//    file: file![0].path,
//     fileBytes: file[0].readAsBytesSync(),
//     folder: sellerName,
//     resourceType: CloudinaryResourceType.image,
//     progressCallback: (count, total) {
//       log('Uploading image from file with progress: $count/$total');
//     },
//   );
//   if (response.isSuccessful && response.secureUrl != null) {
//     return [response.secureUrl!];
//   } else {
//     throw CloudinaryException(
//       message: response.error ?? 'Cloudinary upload failed',
//       statusCode: response.statusCode ?? 500,
//     );
//   }
// }


}
