part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class SignedIn extends AuthState {
  const SignedIn(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class BuyerSignedUp extends AuthState {
  const BuyerSignedUp();
}

class BuyerSigningUp extends AuthState{
  const BuyerSigningUp();
}

class FarmerSignedUp extends AuthState {
  const FarmerSignedUp();
}

class FarmerSigningUp extends AuthState{
  const FarmerSigningUp();
}

class UserTokenCached extends AuthState {
  const UserTokenCached();
}

class InvitationTokenCached extends AuthState{
  const InvitationTokenCached();
}

class UserTokenRetrieved extends AuthState {
  const UserTokenRetrieved(this.token);

  final String token;

  @override
  List<String> get props => [token];
}

class PasswordReset extends AuthState {
  const PasswordReset();
}

class UserSet extends AuthState {
  const UserSet();
}

class UserValidated extends AuthState {
  const UserValidated(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class FarmerInvitationKeyValidated extends AuthState {
  const FarmerInvitationKeyValidated(this.invitationKey);

  final String invitationKey;

  @override
  List<Object> get props => [invitationKey];
}

class ResetPasswordTokenSent extends AuthState {
  const ResetPasswordTokenSent();
}

class UserUpdated extends AuthState {
  const UserUpdated(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class ResetPasswordTokenAuthenticated extends AuthState {
  const ResetPasswordTokenAuthenticated({required this.status});

  final bool status;

  @override
  List<bool> get props => [status];
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
