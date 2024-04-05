import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/storage/hbm_storage.dart';
import 'package:husbandman/core/common/app/token-generator/token_generator.dart';
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
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource_impl.dart';
import 'package:husbandman/src/auth/data/repo/auth_repo_impl.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/authenticate_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/buyer_signup.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_user_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_verified_invitation_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/farmer_signup.dart';
import 'package:husbandman/src/auth/domain/use-cases/reset_password.dart';
import 'package:husbandman/src/auth/domain/use-cases/retrieve_user_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/send_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/set_user.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_in.dart';
import 'package:husbandman/src/auth/domain/use-cases/update_user.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_farmer_invitation_key.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_user.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:husbandman/src/onboarding/data/repo/onboarding_repo_impl.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final sl = GetIt.instance;
//
// Future<void> init() async {
//   final prefs = await SharedPreferences.getInstance();
//   final client = http.Client();
//   final storage = HBMStorage();
//   sl
//     ..registerLazySingleton(() => prefs)
//     ..registerLazySingleton(() => client)
//     ..registerLazySingleton(() => storage)
//     ..registerFactory(
//       () => OnboardingCubit(
//         cacheFirstTimer: sl(),
//         checkIfUserIsFirstTimer: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => CacheFirstTimer(sl()))
//     ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
//     ..registerLazySingleton<OnboardingLocalDataSource>(
//       () => OnboardingLocalDataSrcImpl(sl()),
//     )
//     ..registerSingleton<OnboardingRepo>(
//       OnboardingRepoImpl(sl()),
//     )
//     ..registerFactory(
//       () => AuthBloc(
//         authenticateResetPasswordToken: sl(),
//         signIn: sl(),
//         farmerSignUp: sl(),
//         buyerSignUp: sl(),
//         cacheUserToken: sl(),
//         cacheVerifiedInvitationToken: ,
//         setUser: sl(),
//         retrieveUserToken: sl(),
//         validateUser: sl(),
//         validateFarmerInvitationKey: sl(),
//         resetPassword: sl(),
//         sendResetPasswordToken: sl(),
//         updateUser: sl(),
//       ),
//     )
//     ..registerLazySingleton(
//       () => AuthenticateResetPasswordToken(sl()),
//     )
//     ..registerLazySingleton(
//       () => SignIn(sl()),
//     )
//     ..registerLazySingleton(
//       () => FarmerSignUp(sl()),
//     )
//     ..registerLazySingleton(
//       () => BuyerSignUp(sl()),
//     )
//     ..registerLazySingleton(
//       () => CacheUserToken(sl()),
//     )
//     ..registerLazySingleton(
//       () => SetUser(sl()),
//     )
//     ..registerLazySingleton(
//       () => RetrieveUserToken(sl()),
//     )
//     ..registerLazySingleton(
//       () => ValidateUser(sl()),
//     )
//     ..registerLazySingleton(
//       () => ValidateFarmerInvitationKey(sl()),
//     )
//     ..registerLazySingleton(
//       () => ResetPassword(sl()),
//     )
//     ..registerLazySingleton(
//       () => SendResetPasswordToken(sl()),
//     )
//     ..registerLazySingleton(
//       () => UpdateUser(sl()),
//     );
//   // ..registerSingleton<AuthDataSource>(AuthDataSourceImpl(sl(), sl(), _ref));
// }

//GENERAL DEPENDENCIES
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return sharedPrefs.prefs;
});

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final storageProvider = Provider<HBMStorage>((ref) => HBMStorage());

//ONBOARDING
final onboardingCubitProvider = Provider<OnboardingCubit>((ref) {
  return OnboardingCubit(
    cacheFirstTimer: ref.read(cacheFirstTimerProvider),
    checkIfUserIsFirstTimer: ref.read(checkIfUserIsFirstTimerProvider),
  );
});

//Onboarding Dependencies
final onboardingLocalDatasourceProvider =
Provider<OnboardingLocalDataSource>((ref) {
  return OnboardingLocalDataSrcImpl(ref.read(sharedPreferencesProvider));
});

final onBoardingRepoProvider = Provider<OnboardingRepo>((ref) {
  return OnboardingRepoImpl(ref.read(onboardingLocalDatasourceProvider));
});

//Onboarding Use-cases
final cacheFirstTimerProvider = Provider<CacheFirstTimer>((ref) {
  return CacheFirstTimer(ref.read(onBoardingRepoProvider));
});

final checkIfUserIsFirstTimerProvider =
Provider<CheckIfUserIsFirstTimer>((ref) {
  return CheckIfUserIsFirstTimer(ref.read(onBoardingRepoProvider));
});

//AUTHENTICATION
final authBlocProvider = Provider<AuthBloc>((ref) {
  return AuthBloc(
    authenticateResetPasswordToken:
    ref.read(authenticateResetPasswordTokenProvider),
    signIn: ref.read(signInProvider),
    farmerSignUp: ref.read(farmerSignUpProvider),
    buyerSignUp: ref.read(buyerSignUpProvider),
    cacheUserToken: ref.read(cacheUserTokenProvider),
    cacheVerifiedInvitationToken:
    ref.read(cacheVerifiedInvitationTokenProvider),
    setUser: ref.read(setUserProvider),
    retrieveUserToken: ref.read(retrieveUserTokenProvider),
    validateUser: ref.read(validateUserProvider),
    validateFarmerInvitationKey: ref.read(validateFarmerInvitationKeyProvider),
    resetPassword: ref.read(resetPasswordProvider),
    sendResetPasswordToken: ref.read(sendResetPasswordTokenProvider),
    updateUser: ref.read(updateUserProvider),
  );
});

//Auth Dependencies
final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImpl(ref.read(authDatasourceProvider));
});

final authDatasourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImpl(
    ref.read(httpClientProvider),
    ref.read(storageProvider),
    ref,
  );
});

//Auth Use-cases
final authenticateResetPasswordTokenProvider =
Provider<AuthenticateResetPasswordToken>((ref) {
  return AuthenticateResetPasswordToken(ref.read(authRepoProvider));
});

final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.read(authRepoProvider));
});

final farmerSignUpProvider = Provider<FarmerSignUp>((ref) {
  return FarmerSignUp(ref.read(authRepoProvider));
});

final buyerSignUpProvider = Provider<BuyerSignUp>((ref) {
  return BuyerSignUp(ref.read(authRepoProvider));
});

final cacheUserTokenProvider = Provider<CacheUserToken>((ref) {
  return CacheUserToken(ref.read(authRepoProvider));
});

final cacheVerifiedInvitationTokenProvider =
Provider<CacheVerifiedInvitationToken>((ref) {
  return CacheVerifiedInvitationToken(ref.read(authRepoProvider));
});

final setUserProvider = Provider<SetUser>((ref) {
  return SetUser(ref.read(authRepoProvider));
});

final retrieveUserTokenProvider = Provider<RetrieveUserToken>((ref) {
  return RetrieveUserToken(ref.read(authRepoProvider));
});

final validateUserProvider = Provider<ValidateUser>((ref) {
  return ValidateUser(ref.read(authRepoProvider));
});

final validateFarmerInvitationKeyProvider =
Provider<ValidateFarmerInvitationKey>((ref) {
  return ValidateFarmerInvitationKey(ref.read(authRepoProvider));
});

final resetPasswordProvider = Provider<ResetPassword>((ref) {
  return ResetPassword(ref.read(authRepoProvider));
});

final sendResetPasswordTokenProvider = Provider<SendResetPasswordToken>((ref) {
  return SendResetPasswordToken(ref.read(authRepoProvider));
});

final updateUserProvider = Provider<UpdateUser>((ref) {
  return UpdateUser(ref.read(authRepoProvider));
});

//ADMIN
final adminBlocProvider = Provider<AdminBloc>((ref) {
  return AdminBloc(
      blockAccount: ref.read(blockAccountProvider),
      changeFarmerBadge: ref.read(changeFarmerBadgeProvider),
      deleteAccount: ref.read(deleteAccountProvider),
      fetchAllInvitationToken: ref.read(fetchAllInvitationTokenProvider),
      fetchAllOrders: ref.read(fetchAllOrdersProvider),
      fetchAllUsers: ref.read(fetchAllUsersProvider),
      filterUser: ref.read(filterUserProvider),
      generateUniqueInvitationToken: ref.read(
        generateUniqueInvitationTokenProvider,
      ),
      searchUser: ref.read(searchUserProvider),
      saveInvitationToken: ref.read(saveInvitationTokenProvider),
  );
});

//Admin Dependencies
final tokenGeneratorProvider = Provider<TokenGenerator>((ref) {
  return TokenGenerator();
});

final adminDatasourceProvider = Provider<AdminDatasource>((ref) {
  return AdminDatasourceImpl(
    ref.read(httpClientProvider),
    ref.read(tokenGeneratorProvider),
  );
});

final adminRepoProvider = Provider<AdminRepo>((ref) {
  return AdminRepoImpl(ref.read(adminDatasourceProvider));
});

//Admin Use-cases
final blockAccountProvider = Provider<BlockAccount>((ref) {
  return BlockAccount(ref.read(adminRepoProvider));
});

final changeFarmerBadgeProvider = Provider<ChangeFarmerBadge>((ref) {
  return ChangeFarmerBadge(ref.read(adminRepoProvider));
});

final deleteAccountProvider = Provider<DeleteAccount>((ref) {
  return DeleteAccount(ref.read(adminRepoProvider));
});

final fetchAllInvitationTokenProvider =
Provider<FetchAllInvitationToken>((ref) {
  return FetchAllInvitationToken(ref.read(adminRepoProvider));
});

final fetchAllOrdersProvider = Provider<FetchAllOrders>((ref) {
  return FetchAllOrders(ref.read(adminRepoProvider));
});

final fetchAllUsersProvider = Provider<FetchAllUsers>((ref) {
  return FetchAllUsers(ref.read(adminRepoProvider));
});

final filterUserProvider = Provider<FilterUser>((ref) {
  return FilterUser(ref.read(adminRepoProvider));
});

final generateUniqueInvitationTokenProvider =
Provider<GenerateUniqueInvitationToken>((ref) {
  return GenerateUniqueInvitationToken(ref.read(adminRepoProvider));
});

final searchUserProvider = Provider<SearchUser>((ref) {
  return SearchUser(ref.read(adminRepoProvider));
});

final saveInvitationTokenProvider = Provider<SaveInvitationToken>((ref) {
  return SaveInvitationToken(ref.read(adminRepoProvider));
});
// Define other providers similarly...
