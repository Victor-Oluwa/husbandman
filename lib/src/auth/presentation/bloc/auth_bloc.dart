import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:husbandman/src/auth/domain/use-cases/authenticate_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_user_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_verified_invitation_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/farmer_signup.dart';
import 'package:husbandman/src/auth/domain/use-cases/reset_password.dart';
import 'package:husbandman/src/auth/domain/use-cases/retrieve_user_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/send_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/set_user.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_in.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_out.dart';
import 'package:husbandman/src/auth/domain/use-cases/signup.dart';
import 'package:husbandman/src/auth/domain/use-cases/update_user.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_farmer_invitation_key.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthenticateResetPasswordToken authenticateResetPasswordToken,
    required SignIn signIn,
    required SignOut signOut,
    required FarmerSignUp farmerSignUp,
    required SignUp signUp,
    required CacheUserToken cacheUserToken,
    required CacheVerifiedInvitationToken cacheVerifiedInvitationToken,
    required SetUser setUser,
    required RetrieveUserToken retrieveUserToken,
    required ValidateUser validateUser,
    required ValidateFarmerInvitationKey validateFarmerInvitationKey,
    required ResetPassword resetPassword,
    required SendResetPasswordToken sendResetPasswordToken,
    required UpdateUser updateUser,
  })  : _authenticateResetPasswordToken = authenticateResetPasswordToken,
        _signIn = signIn,
        _signOut = signOut,
        _farmerSignUp = farmerSignUp,
        _signUp = signUp,
        _cacheUserToken = cacheUserToken,
        _cacheVerifiedInvitationToken = cacheVerifiedInvitationToken,
        _setUser = setUser,
        _retrieveUserToken = retrieveUserToken,
        _validateUser = validateUser,
        _validateFarmerInvitationKey = validateFarmerInvitationKey,
        _resetPassword = resetPassword,
        _sendResetPasswordToken = sendResetPasswordToken,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<AuthenticateResetPasswordTokenEvent>(
      _authenticateResetPasswordTokenHandler,
    );
    on<SignInEvent>(_signInHandler);
    on<SignOutEvent>(_signOutHandler);
    on<SignUpEvent>(_signUpHandler);
    on<FarmerSignUpEvent>(_farmerSignUpHandler);
    on<CacheUserTokenEvent>(_cacheUserTokenHandler);
    on<CacheVerifiedInvitationTokenEvent>(_cacheVerifiedInvitationTokenHandler);
    on<SetUserEvent>(_setUserHandler);
    on<RetrieveUserTokenEvent>(_retrieveUserTokenHandler);
    on<ValidateUserEvent>(_validateUserHandler);
    on<ValidateFarmerInvitationKeyEvent>(_validateFarmerInvitationKeyEvent);
    on<ResetPasswordEvent>(_resetPasswordHandler);
    on<SendResetPasswordTokenEvent>(_sendResetPasswordTokenHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  final AuthenticateResetPasswordToken _authenticateResetPasswordToken;
  final SignIn _signIn;
  final SignOut _signOut;
  final SignUp _signUp;
  final FarmerSignUp _farmerSignUp;
  final CacheUserToken _cacheUserToken;
  final CacheVerifiedInvitationToken _cacheVerifiedInvitationToken;
  final SetUser _setUser;
  final RetrieveUserToken _retrieveUserToken;
  final ValidateUser _validateUser;
  final ValidateFarmerInvitationKey _validateFarmerInvitationKey;
  final ResetPassword _resetPassword;
  final SendResetPasswordToken _sendResetPasswordToken;
  final UpdateUser _updateUser;

  Future<void> _authenticateResetPasswordTokenHandler(
    AuthenticateResetPasswordTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authenticateResetPasswordToken(event.token);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        ResetPasswordTokenAuthenticated(status: r),
      ),
    );
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (l) {
        emit(AuthError(l.errorMessage));
        log('Error from blo: ${l.errorMessage}');
      },
      (r) => emit(
        SignedIn(r),
      ),
    );
  }

  Future<void> _signOutHandler(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signOut();

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (_) => emit(
        const SignedOut(),
      ),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
        type: event.type,
        address: event.address,
      ),
    );

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        SignedUp(r),
      ),
    );
  }

  Future<void> _farmerSignUpHandler(
    FarmerSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _farmerSignUp(
      FarmerSignUpParams(
        seller: event.seller,
        invitationKey: event.invitationKey,
      ),
    );

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(FarmerSignedUp(r)),
    );
  }

  Future<void> _cacheUserTokenHandler(
    CacheUserTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _cacheUserToken(event.token);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (_) => emit(
        const UserTokenCached(),
      ),
    );
  }

  Future<void> _cacheVerifiedInvitationTokenHandler(
    CacheVerifiedInvitationTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _cacheVerifiedInvitationToken(event.token);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        const InvitationTokenCached(),
      ),
    );
  }

  Future<void> _setUserHandler(
    SetUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _setUser(event.user);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserSet(r),
      ),
    );
  }

  Future<void> _retrieveUserTokenHandler(
    RetrieveUserTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _retrieveUserToken();

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserTokenRetrieved(r),
      ),
    );
  }

  Future<void> _validateUserHandler(
    ValidateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _validateUser(event.token);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserValidated(r),
      ),
    );
  }

  Future<void> _validateFarmerInvitationKeyEvent(
    ValidateFarmerInvitationKeyEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _validateFarmerInvitationKey(event.invitationKey);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        FarmerInvitationKeyValidated(r),
      ),
    );
  }

  Future<void> _resetPasswordHandler(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _resetPassword(event.newPassword);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        const PasswordReset(),
      ),
    );
  }

  Future<void> _sendResetPasswordTokenHandler(
    SendResetPasswordTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _sendResetPasswordToken(event.email);

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (_) => emit(
        const ResetPasswordTokenSent(),
      ),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(
      UpdateUserParams(
        newData: event.newData,
        culprit: event.culprit,
      ),
    );

    result.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(
        UserUpdated(r),
      ),
    );
  }
}
