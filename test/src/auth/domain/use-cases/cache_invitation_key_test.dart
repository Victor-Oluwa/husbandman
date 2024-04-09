// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:husbandman/core/error/failure.dart';
// import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
// import 'package:husbandman/src/auth/domain/use-cases/cache_invitation_key.dart';
// import 'package:mocktail/mocktail.dart';
//
// import 'auth_repo.mock.dart';
//
// void main() {
//   late AuthRepo authRepo;
//   late CacheInvitationKey usecase;
//
//   const tToken = 'token';
//
//   setUp(() {
//     authRepo = MockAuthRepo();
//     usecase = CacheInvitationKey(authRepo);
//   });
//   group('Cache Invitation Key', () {
//     test('Should call [AuthRepo] nd return [Right<void>] when successful',
//         () async {
//       when(
//         () => authRepo.cacheInvitationKey(
//           key: any(named: 'key'),
//         ),
//       ).thenAnswer((_) async => const Right(null));
//
//       final result = await usecase(tToken);
//       expect(result, equals(const Right<dynamic, void>(null)));
//
//       verify(() => authRepo.cacheInvitationKey(key: tToken))
//           .called(1);
//       verifyNoMoreInteractions(authRepo);
//     });
//
//     test('Should call [AuthRepo] nd return [Right<void>] when successful',
//         () async {
//       when(
//         () => authRepo.cacheInvitationKey(
//           key: any(named: 'key'),
//         ),
//       ).thenAnswer(
//         (_) async => Left(
//           ServerFailure(message: 'Failed to cache key', statusCode: 400),
//         ),
//       );
//
//       final result = await usecase(tToken);
//       expect(
//         result,
//         equals(
//           Left<ServerFailure, dynamic>(
//             ServerFailure(message: 'Failed to cache key', statusCode: 400),
//           ),
//         ),
//       );
//
//       verify(() => authRepo.cacheInvitationKey(key: tToken))
//           .called(1);
//       verifyNoMoreInteractions(authRepo);
//     });
//   });
// }
