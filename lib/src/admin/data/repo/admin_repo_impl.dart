import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class AdminRepoImpl implements AdminRepo {
  const AdminRepoImpl(this._adminDatasource);

  final AdminDatasource _adminDatasource;

  @override
  ResultFuture<void> blockAccount({required String accountId}) async {
    try {
      await _adminDatasource.blockAccount(accountId: accountId);
      return const Right(null);
    } on AdminException catch (e) {
      return Left(AdminFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> changeFarmerBadge({
    required String farmerId,
    required int badge,
  }) async {
    try {
      await _adminDatasource.changeFarmerBadge(
        farmerId: farmerId,
        badge: badge,
      );
      return const Right(null);
    } on AdminException catch (e) {
      return Left(
        AdminFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> deleteAccount({required String userId}) async {
    try {
      await _adminDatasource.deleteAccount(userId: userId);
      return const Right(null);
    } on AdminException catch (e) {
      return Left(
        AdminFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<List<InvitationTokenEntity>> fetchAllInvitationToken() async {
    try {
      final result = await _adminDatasource.fetchAllInvitationToken();
      return Right(result);
    } on AdminException catch (e) {
      return Left(AdminFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<DataMap>> fetchAllUsers() async {
    try {
      final result = await _adminDatasource.fetchAllUsers();
      return Right(result);
    } on AdminException catch (e) {
      return Left(AdminFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<DataMap>> filterUser({
    required FilterUserProperty property,
    required dynamic value,
  }) async {
    try {
      final result = await _adminDatasource.filterUser(
        property: property,
        value: value,
      );
      return Right(result);
    } on AdminException catch (e) {
      return Left(AdminFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> generateUniqueInvitationToken() async {
    try {
      final result = await _adminDatasource.generateUniqueInvitationToken();
      return Right(result);
    } on AdminException catch (e) {
      return Left(AdminFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<DataMap>> searchUser({
    required String query,
    required SearchUserProperty property,
  }) async {
    try {
      final result = await _adminDatasource.searchUser(
        query: query,
        property: property,
      );
      return Right(result);
    } on AdminException catch (e) {
      return Left(AdminFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> shareInvitationTokenToEmail({
    required String token,
    required String emailAddress,
  }) async {
    try {
      await _adminDatasource.shareInvitationTokenToEmail(
        token: token,
        emailAddress: emailAddress,
      );
      return const Right(null);
    } on AdminException catch (e) {
      return Left(AdminFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> shareInvitationTokenToWhatsApp({required String token}) async{
   try{
     await _adminDatasource.shareInvitationTokenToWhatsApp(token: token);
     return const Right(null);
   } on AdminException catch(e){
     return Left(AdminFailure.fromException(e));
   }
  }

  @override
  ResultFuture<void> saveInvitationToken({required String key})async {
 try{
   final result = await _adminDatasource.saveInvitationToken(key: key);
   return Right(result);
 } on AdminException catch(e){
   return Left(AdminFailure.fromException(e));
 }
  }
}
