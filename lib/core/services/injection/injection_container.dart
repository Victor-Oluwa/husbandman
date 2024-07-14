import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/public_methods/cloudinary_upload/cloudinary_upload.dart';
import 'package:husbandman/core/common/app/public_methods/file-picker/file_picker.dart';
import 'package:husbandman/core/common/app/public_methods/file_compressor/file_compressor.dart';
import 'package:husbandman/core/common/app/public_methods/superbase_upload/superbase_upload.dart';
import 'package:husbandman/core/common/app/storage/hbm_storage.dart';
import 'package:husbandman/core/services/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

//GENERAL DEPENDENCIES
final sharedPreferencesProvider =
    Provider.autoDispose<SharedPreferences>((ref) {
  return sharedPrefs.prefs;
});

final httpClientProvider = Provider.autoDispose<http.Client>(
  (ref) => http.Client(),
);
final dioProvider = Provider.autoDispose<Dio>((ref) {
  return Dio();
});
final storageProvider = Provider.autoDispose<HBMStorage>((ref) => HBMStorage());
final cloudinaryUploadProvider = Provider.autoDispose<CloudinaryUpload>(
  (ref) => CloudinaryUpload(),
);

final pickFileProvider = Provider.autoDispose<PickFile>((ref) => PickFile());
final compressorProvider =
    Provider.autoDispose<FileCompressor>((ref) => FileCompressor());
final superBaseUploadProvider =
    Provider.autoDispose<SuperBaseUpload>((ref) => SuperBaseUpload());

// Define other providers similarly...
