import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/public_methods/cloudinary_upload/cloudinary_upload.dart';
import 'package:husbandman/core/common/app/public_methods/file-picker/file_picker.dart';
import 'package:husbandman/core/common/app/public_methods/file_compressor/file_compressor.dart';
import 'package:husbandman/core/common/app/storage/hbm_storage.dart';
import 'package:husbandman/core/common/app/public_methods/token-generator/token_generator.dart';
import 'package:husbandman/core/services/shared_preference.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource_impl.dart';
import 'package:husbandman/src/admin/data/repo/admin_repo_impl.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/block_account.dart';
import 'package:husbandman/src/admin/domain/use-cases/change_farmer_badge.dart';
import 'package:husbandman/src/admin/domain/use-cases/delete_account.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_invitation_token.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_orders.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_users.dart';
import 'package:husbandman/src/admin/domain/use-cases/filter_user.dart';
import 'package:husbandman/src/admin/domain/use-cases/generate_unique_invitation_token.dart';
import 'package:husbandman/src/admin/domain/use-cases/save_invitation_token.dart';
import 'package:husbandman/src/admin/domain/use-cases/search_user.dart';
import 'package:husbandman/src/admin/presentation/bloc/admin_bloc.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:husbandman/src/onboarding/data/repo/onboarding_repo_impl.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

//GENERAL DEPENDENCIES
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return sharedPrefs.prefs;
});

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final storageProvider = Provider<HBMStorage>((ref) => HBMStorage());
final cloudinaryUploadProvider = Provider<CloudinaryUpload>(
  (ref) => CloudinaryUpload(),
);

final pickFileProvider = Provider<PickFile>((ref) => PickFile());
final compressorProvider = Provider<FileCompressor>((ref) => FileCompressor());

// Define other providers similarly...
