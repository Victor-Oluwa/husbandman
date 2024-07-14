import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._authDataSource);

  final AuthDataSource _authDataSource;

  @override
  ResultFuture<bool> authenticateResetPasswordToken({
    required String token,
  }) async {
    try {
      final result =
          await _authDataSource.authenticateResetPasswordToken(token: token);
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<UserModel> buyerSignUp({
    required String name,
    required String email,
    required String password,
    required String type,
    required String address,
  }) async {
    try {
      final result = await _authDataSource.buyerSignUp(
        name: name,
        email: email,
        password: password,
        type: type,
        address: address,
      );
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<void> cacheUserToken({required String token}) async {
    try {
      await _authDataSource.cacheUserToken(token: token);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> cacheVerifiedInvitationToken({
    required String token,
  }) async {
    try {
      final result =
          await _authDataSource.cacheVerifiedInvitationToken(token: token);
      return Right(result);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<UserModel> farmerSignUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String type,
    required String invitationKey,
  }) async {
    try {
    final result = await _authDataSource.farmerSignUp(
        name: name,
        email: email,
        password: password,
        address: address,
        type: type,
        invitationKey: invitationKey,
      );
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<void> resetPassword({required String newPassword}) async {
    try {
      await _authDataSource.resetPassword(newPassword: newPassword);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<void> sendResetPasswordToken({
    required String email,
  }) async {
    try {
      await _authDataSource.sendResetPasswordToken(email: email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<String> retrieveUserToken() async {
    try {
      final result = await _authDataSource.retrieveUserToken();
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<UserModel> setUser({required DataMap user}) async {
    try {
      final result = await _authDataSource.setUser(user: user);
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<void> signOut()async {
    try {
      final result = await _authDataSource.signOut();
      return Right(result);
    } on AuthException catch (e) {
      return Left(AuthFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserModel> updateUser({
    required dynamic newData,
    required UpdateUserCulprit culprit,
  }) async {
    try {
      final result = await _authDataSource.updateUser(
        newData: newData,
        culprit: culprit,
      );
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<UserModel> validateUser({required String token}) async {
    try {
      final result = await _authDataSource.validateUser(token: token);
      return Right(result);
    } on AuthException catch (e) {
      return Left(
        AuthFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<String> validateFarmerInvitationKey({
    required String invitationKey,
  }) async {
    try {
      final result = await _authDataSource.validateFarmerInvitationKey(
        invitationKey: invitationKey,
      );
      return Right(result);
    } on AuthException catch (e) {
      return Left(AuthFailure.fromException(e));
    }
  }
}
