part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthenticateResetPasswordTokenEvent extends AuthEvent {
  const AuthenticateResetPasswordTokenEvent({required this.token});

  final String token;

  @override
  List<String> get props => [token];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class BuyerSignUpEvent extends AuthEvent {
  const BuyerSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.address,
  });

  final String name;
  final String email;
  final String password;
  final String type;
  final String address;

  @override
  List<String> get props => [name, email, password, type, address];
}

class CacheUserTokenEvent extends AuthEvent {
  const CacheUserTokenEvent({required this.token});

  final String token;

  @override
  List<String> get props => [token];
}

class CacheVerifiedInvitationTokenEvent extends AuthEvent{
  const CacheVerifiedInvitationTokenEvent({required this.token});
  final String token;

  @override
  List<String> get props => [token];
}

class FarmerSignUpEvent extends AuthEvent {
  const FarmerSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.invitationKey,
  });

  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String invitationKey;

  @override
  List<String> get props => [name, email, password, address, type];
}

class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({required this.newPassword});

  final String newPassword;

  @override
  List<String> get props => [newPassword];
}

class RetrieveUserTokenEvent extends AuthEvent {
  @override
  List<String> get props => [];
}

class SetUserEvent extends AuthEvent {
  const SetUserEvent({required this.user});

  final DataMap user;

  @override
  List<Object> get props => [user];
}

class SendResetPasswordTokenEvent extends AuthEvent {
  const SendResetPasswordTokenEvent({required this.email});

  final String email;

  @override
  List<String> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({
    required this.newData,
    required this.culprit,
  }) : assert(
            newData is String || newData is File,
            'User data must be either a '
            " [String] or a [File]. It can't be a ${newData.runtimeType}");

  final dynamic newData;
  final UpdateUserCulprit culprit;

  @override
  List<dynamic> get props => [newData, culprit];
}

class ValidateUserEvent extends AuthEvent {
  const ValidateUserEvent({required this.token});

  final String token;

  @override
  List<String> get props => [token];
}

class ValidateFarmerInvitationKeyEvent extends AuthEvent {
  const ValidateFarmerInvitationKeyEvent({required this.invitationKey});

  final String invitationKey;

  @override
  List<String> get props => [invitationKey];
}
