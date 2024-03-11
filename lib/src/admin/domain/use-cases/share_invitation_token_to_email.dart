import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class ShareInvitationTokenToEmail
    extends UseCaseWithParams<void, ShareInvitationTokenToEmailParams> {
  const ShareInvitationTokenToEmail(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<void> call(ShareInvitationTokenToEmailParams params) =>
      _adminRepo.shareInvitationTokenToEmail(
        token: params.token,
        emailAddress: params.emailAddress,
      );
}

class ShareInvitationTokenToEmailParams extends Equatable {
  const ShareInvitationTokenToEmailParams({
    required this.token,
    required this.emailAddress,
  });

  const ShareInvitationTokenToEmailParams.empty()
      : this(
          token: 'empty.token',
          emailAddress: 'empty.address',
        );

  final String token;
  final String emailAddress;

  @override
  List<Object> get props => [token, emailAddress];
}
