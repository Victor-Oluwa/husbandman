// import 'package:dartz/dartz.dart';
// import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';
// import 'package:husbandman/core/common/app/models/order_model.dart';
// import 'package:husbandman/core/common/app/models/user/user_model.dart';
// import 'package:husbandman/core/enums/filter_user.dart';
// import 'package:husbandman/core/enums/search_user.dart';
// import 'package:husbandman/core/error/exceptions.dart';
// import 'package:husbandman/core/error/failure.dart';
// import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
// import 'package:husbandman/src/admin/data/repo/admin_repo_impl.dart';
// import 'package:husbandman/src/admin/domain/use-cases/filter_user.dart';
// import 'package:husbandman/src/admin/domain/use-cases/search_user.dart';
// import 'package:husbandman/src/admin/domain/use-cases/share_invitation_token_to_email.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
//
// class MockAdminDatasource extends Mock implements AdminDatasource {}
//
// void main() {
//   late AdminDatasource adminDatasource;
//   late AdminRepoImpl adminRepoImpl;
//
//   setUp(() {
//     adminDatasource = MockAdminDatasource();
//     adminRepoImpl = AdminRepoImpl(adminDatasource);
//   });
//
//   group('Block Account', () {
//     const tAccountId = 'accountId';
//     test('Should call [AdminDatasource] return [Right(void)]', () async {
//       when(
//         () => adminDatasource.blockAccount(
//           accountId: any(named: 'accountId'),
//         ),
//       ).thenAnswer((_) async => Future.value);
//
//       final result = await adminRepoImpl.blockAccount(accountId: tAccountId);
//
//       expect(
//         result,
//         equals(
//           const Right<dynamic, void>(null),
//         ),
//       );
//
//       verify(() => adminDatasource.blockAccount(accountId: tAccountId));
//       verifyNoMoreInteractions(adminDatasource);
//     });
//
//     test('Should call [AdminDatasource] return [Left(AdminFailure)]', () async {
//       when(
//         () => adminDatasource.blockAccount(
//           accountId: any(named: 'accountId'),
//         ),
//       ).thenThrow(
//         const AdminException(
//           message: 'Failed to block account',
//           statusCode: 404,
//         ),
//       );
//
//       final result = await adminRepoImpl.blockAccount(accountId: tAccountId);
//
//       expect(
//         result,
//         equals(
//           Left<AdminFailure, dynamic>(
//             AdminFailure(
//               message: 'Failed to block account',
//               statusCode: 404,
//             ),
//           ),
//         ),
//       );
//
//       verify(() => adminDatasource.blockAccount(accountId: tAccountId));
//       verifyNoMoreInteractions(adminDatasource);
//     });
//   });
//
//   group('Change Farmer Badge', () {
//     const tFarmerId = 'farmer-id';
//     const tBadge = 2;
//     test(
//       'Should call [AdminDatasource] '
//       'and return [Right(void)] when successful',
//       () async {
//         when(
//           () => adminDatasource.changeFarmerBadge(
//             farmerId: any(named: 'farmerId'),
//             badge: any(named: 'badge'),
//           ),
//         ).thenAnswer((_) async => Future.value);
//
//         final result = await adminRepoImpl.changeFarmerBadge(
//           farmerId: tFarmerId,
//           badge: tBadge,
//         );
//         expect(result, equals(const Right<dynamic, void>(null)));
//
//         verify(
//           () => adminDatasource.changeFarmerBadge(
//             farmerId: tFarmerId,
//             badge: tBadge,
//           ),
//         );
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//         'Should call [AdminDatasource] and return [Left(AdminFailure)] when successful',
//         () async {
//       when(
//         () => adminDatasource.changeFarmerBadge(
//           farmerId: any(named: 'farmerId'),
//           badge: any(named: 'badge'),
//         ),
//       ).thenThrow(
//         const AdminException(
//           message: 'Failed to change user badge',
//           statusCode: 404,
//         ),
//       );
//
//       final result = await adminRepoImpl.changeFarmerBadge(
//         farmerId: tFarmerId,
//         badge: tBadge,
//       );
//       expect(
//         result,
//         equals(
//           Left<AdminFailure, dynamic>(
//             AdminFailure(
//               message: 'Failed to change user badge',
//               statusCode: 404,
//             ),
//           ),
//         ),
//       );
//
//       verify(
//         () => adminDatasource.changeFarmerBadge(
//           farmerId: tFarmerId,
//           badge: tBadge,
//         ),
//       );
//       verifyNoMoreInteractions(adminDatasource);
//     });
//   });
//
//   group('Delete Account', () {
//     const tUserId = 'user-id';
//     test(
//       'Should call [AdminDatSource] and return [Right(void)] when successful',
//       () async {
//         when(
//           () => adminDatasource.deleteAccount(
//             userId: any(named: 'userId'),
//           ),
//         ).thenAnswer((_) async => Future.value);
//
//         final result = await adminRepoImpl.deleteAccount(userId: tUserId);
//         expect(result, equals(const Right<dynamic, void>(null)));
//
//         verify(() => adminDatasource.deleteAccount(userId: tUserId)).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//         'Should call [AdminDatasource] and return [Left(AdminFailure) when unsuccessful]',
//         () async {
//       when(
//         () => adminDatasource.deleteAccount(
//           userId: any(named: 'userId'),
//         ),
//       ).thenThrow(
//         const AdminException(
//           message: 'Failed to delete account',
//           statusCode: 404,
//         ),
//       );
//
//       final result = await adminRepoImpl.deleteAccount(userId: tUserId);
//       expect(
//         result,
//         equals(
//           Left<AdminFailure, dynamic>(
//             AdminFailure(
//               message: 'Failed to delete account',
//               statusCode: 404,
//             ),
//           ),
//         ),
//       );
//
//       verify(() => adminDatasource.deleteAccount(userId: tUserId)).called(1);
//       verifyNoMoreInteractions(adminDatasource);
//     });
//   });
//
//   group('Fetch All Orders', () {
//     final tOrders = [const OrderModel.empty()];
//     test(
//       'Should call [AdminDatasource] and return Right(List<OrderModel>)',
//       () async {
//         when(() => adminDatasource.fetchAllOrders()).thenAnswer(
//           (_) async => tOrders,
//         );
//
//         final result = await adminRepoImpl.fetchAllOrders();
//         expect(result, equals(Right<dynamic, List<OrderModel>>(tOrders)));
//
//         verify(() => adminDatasource.fetchAllOrders()).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//         'Should call [AdminDatasource] and return [Left(AdminFailure) when unsuccessful',
//         () async {
//       when(() => adminDatasource.fetchAllOrders()).thenThrow(
//         const AdminException(
//           message: 'Failed to fetch orders',
//           statusCode: 404,
//         ),
//       );
//
//       final result = await adminRepoImpl.fetchAllOrders();
//       expect(
//         result,
//         equals(
//           Left<AdminFailure, dynamic>(
//             AdminFailure(
//               message: 'Failed to fetch orders',
//               statusCode: 404,
//             ),
//           ),
//         ),
//       );
//
//       verify(() => adminDatasource.fetchAllOrders()).called(1);
//       verifyNoMoreInteractions(adminDatasource);
//     });
//   });
//
//   group('Fetch All Invitation Token', () {
//     const tInvitationTokens = [InvitationTokenEntity.empty()];
//     test(
//       'Should call [AdminDatasource] and return [Right(List<InvitationTokenEntity>)]',
//       () async {
//         when(() => adminDatasource.fetchAllInvitationToken()).thenAnswer(
//           (_) async => tInvitationTokens,
//         );
//
//         final result = await adminRepoImpl.fetchAllInvitationToken();
//         expect(
//           result,
//           equals(
//             const Right<dynamic, List<InvitationTokenEntity>>(
//               tInvitationTokens,
//             ),
//           ),
//         );
//
//         verify(() => adminDatasource.fetchAllInvitationToken()).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//         'Should call [AdminDatasource] and return [Right(List<InvitationTokenEntity>)]',
//         () async {
//       when(() => adminDatasource.fetchAllInvitationToken()).thenThrow(
//         const AdminException(
//           message: 'Failed to fetch Tokens',
//           statusCode: 404,
//         ),
//       );
//
//       final result = await adminRepoImpl.fetchAllInvitationToken();
//       expect(
//         result,
//         equals(
//           Left<AdminFailure, dynamic>(
//             AdminFailure(
//               message: 'Failed to fetch Tokens',
//               statusCode: 404,
//             ),
//           ),
//         ),
//       );
//
//       verify(() => adminDatasource.fetchAllInvitationToken()).called(1);
//       verifyNoMoreInteractions(adminDatasource);
//     });
//   });
//
//   group('Fetch All Users', () {
//     final tUsers = [UserModel.empty()];
//     test(
//       'Should call [AdminDatasource]',
//       () async {
//         when(() => adminDatasource.fetchAllUsers()).thenAnswer(
//           (_) async => tUsers,
//         );
//
//         final result = await adminRepoImpl.fetchAllUsers();
//         expect(result, equals(Right<dynamic, List<UserModel>>(tUsers)));
//
//         verify(() => adminDatasource.fetchAllUsers()).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//       'Should call [AdminDatasource] and return [Left(AdminFailure)]',
//       () async {
//         when(() => adminDatasource.fetchAllUsers()).thenThrow(
//           const AdminException(
//             message: 'Failed to fetch users',
//             statusCode: 404,
//           ),
//         );
//
//         final result = await adminRepoImpl.fetchAllUsers();
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(
//                 message: 'Failed to fetch users',
//                 statusCode: 404,
//               ),
//             ),
//           ),
//         );
//
//         verify(() => adminDatasource.fetchAllUsers()).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
//
//   group('Filter User', () {
//     final tUsers = [UserModel.empty()];
//     const tFilterUserParams = FilterUserParams.empty();
//
//     registerFallbackValue(FilterUserProperty.type);
//     test(
//       'Should call [AdminDatasource]',
//       () async {
//         when(
//           () => adminDatasource.filterUser(
//             property: any(named: 'property'),
//             value: any<String>(named: 'value'),
//           ),
//         ).thenAnswer(
//           (_) async => tUsers,
//         );
//
//         final result = await adminRepoImpl.filterUser(
//           property: tFilterUserParams.property,
//           value: tFilterUserParams.value,
//         );
//         expect(result, equals(Right<dynamic, List<UserModel>>(tUsers)));
//
//         verify(
//           () => adminDatasource.filterUser(
//             property: tFilterUserParams.property,
//             value: tFilterUserParams.value,
//           ),
//         ).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//       'Should call [AdminDatasource] and return [Left(AdminFailure)]',
//       () async {
//         when(
//           () => adminDatasource.filterUser(
//             property: any(named: 'property'),
//             value: any<String>(
//               named: 'value',
//             ),
//           ),
//         ).thenThrow(
//           const AdminException(
//             message: 'Failed to fetch users',
//             statusCode: 404,
//           ),
//         );
//
//         final result = await adminRepoImpl.filterUser(
//           property: tFilterUserParams.property,
//           value: tFilterUserParams.value,
//         );
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(
//                 message: 'Failed to fetch users',
//                 statusCode: 404,
//               ),
//             ),
//           ),
//         );
//
//         verify(
//           () => adminDatasource.filterUser(
//             property: tFilterUserParams.property,
//             value: tFilterUserParams.value,
//           ),
//         ).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
//
//   group('Generate Unique Invitation Token', () {
//     const tUniqueToken = 'unique-token';
//     test(
//       'Should call [AdminDatasource] and return [Right<dynamic, String>()]',
//       () async {
//         when(() => adminDatasource.generateUniqueInvitationToken()).thenAnswer(
//           (_) async => tUniqueToken,
//         );
//
//         final result = await adminRepoImpl.generateUniqueInvitationToken();
//         expect(result, equals(const Right<dynamic, String>(tUniqueToken)));
//
//         verify(() => adminDatasource.generateUniqueInvitationToken()).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//       'Should call AdminDatasource and return Left<AdminFailure, dynamic>()',
//       () async {
//         when(() => adminDatasource.generateUniqueInvitationToken()).thenThrow(
//           const AdminException(
//             message: 'Failed to generate token',
//             statusCode: 404,
//           ),
//         );
//
//         final result = await adminRepoImpl.generateUniqueInvitationToken();
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(
//                 message: 'Failed to generate token',
//                 statusCode: 404,
//               ),
//             ),
//           ),
//         );
//
//         verify(() => adminDatasource.generateUniqueInvitationToken()).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
//
//   group('Search User', () {
//     const tSearchUserParams = SearchUserParams.empty();
//     final tUsers = [UserModel.empty()];
//
//     registerFallbackValue(SearchUserProperty.name);
//     test(
//       'Should call AdminDatasource and return Right<dynamic, List<UserModel>>()',
//       () async {
//         when(
//           () => adminDatasource.searchUser(
//             query: any(named: 'query'),
//             property: any(named: 'property'),
//           ),
//         ).thenAnswer((_) async => tUsers);
//
//         final result = await adminRepoImpl.searchUser(
//           query: tSearchUserParams.query,
//           property: tSearchUserParams.property,
//         );
//         expect(result, equals(Right<dynamic, List<UserModel>>(tUsers)));
//
//         verify(
//           () => adminDatasource.searchUser(
//             query: tSearchUserParams.query,
//             property: tSearchUserParams.property,
//           ),
//         ).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//       'Should call AdminDatasource and return Left<AdminFailure, dynamic>',
//       () async {
//         when(
//           () => adminDatasource.searchUser(
//             query: any(named: 'query'),
//             property: any(named: 'property'),
//           ),
//         ).thenThrow(
//           const AdminException(
//             message: 'Failed to find user',
//             statusCode: 404,
//           ),
//         );
//
//         final result = await adminRepoImpl.searchUser(
//           query: tSearchUserParams.query,
//           property: tSearchUserParams.property,
//         );
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(
//                 message: 'Failed to find user',
//                 statusCode: 404,
//               ),
//             ),
//           ),
//         );
//
//         verify(
//           () => adminDatasource.searchUser(
//             query: tSearchUserParams.query,
//             property: tSearchUserParams.property,
//           ),
//         ).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
//
//   group('Share Invitation Token To Email', () {
//     const tParams = ShareInvitationTokenToEmailParams.empty();
//     test('Should call AdminDatasource and return Right<void>', () async {
//       when(
//         () => adminDatasource.shareInvitationTokenToEmail(
//           token: any(named: 'token'),
//           emailAddress: any(
//             named: 'emailAddress',
//           ),
//         ),
//       ).thenAnswer((_) async => Future.value);
//
//       final result = await adminRepoImpl.shareInvitationTokenToEmail(
//         token: tParams.token,
//         emailAddress: tParams.emailAddress,
//       );
//       expect(result, equals(const Right<dynamic, void>(null)));
//
//       verify(
//         () => adminDatasource.shareInvitationTokenToEmail(
//           token: tParams.token,
//           emailAddress: tParams.emailAddress,
//         ),
//       );
//       verifyNoMoreInteractions(adminDatasource);
//     });
//
//     test(
//       'Should call AdminDatasource and return Left<AdminFailure, dynamic>',
//       () async {
//         when(
//           () => adminDatasource.shareInvitationTokenToEmail(
//             token: any(named: 'token'),
//             emailAddress: any(named: 'emailAddress'),
//           ),
//         ).thenThrow(
//           const AdminException(
//             message: 'Failed to send email',
//             statusCode: 404,
//           ),
//         );
//
//         final result = await adminRepoImpl.shareInvitationTokenToEmail(
//           token: tParams.token,
//           emailAddress: tParams.emailAddress,
//         );
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(
//                 message: 'Failed to send email',
//                 statusCode: 404,
//               ),
//             ),
//           ),
//         );
//
//         verify(
//           () => adminDatasource.shareInvitationTokenToEmail(
//             token: tParams.token,
//             emailAddress: tParams.emailAddress,
//           ),
//         );
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
//
//   group('Share Invitation Token To WhatsApp', () {
//     const tToken = 'token';
//     test(
//       'Should call AdminDatasource and return Right<void>()',
//       () async {
//         when(
//           () => adminDatasource.shareInvitationTokenToWhatsApp(
//             token: any(named: 'token'),
//           ),
//         ).thenAnswer((_) async => Future.value);
//
//         final result = await adminRepoImpl.shareInvitationTokenToWhatsApp(
//           token: tToken,
//         );
//         expect(result, equals(const Right<dynamic, void>(null)));
//
//         verify(
//           () => adminDatasource.shareInvitationTokenToWhatsApp(
//             token: tToken,
//           ),
//         );
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//       'Should call AdminDatasource and return Left(AdminFailure)',
//       () async {
//         when(
//           () => adminDatasource.shareInvitationTokenToWhatsApp(
//             token: any(named: 'token'),
//           ),
//         ).thenThrow(
//           const AdminException(
//             message: 'Failed to send token',
//             statusCode: 404,
//           ),
//         );
//
//         final result = await adminRepoImpl.shareInvitationTokenToWhatsApp(
//           token: tToken,
//         );
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(
//                 message: 'Failed to send token',
//                 statusCode: 404,
//               ),
//             ),
//           ),
//         );
//
//         verify(
//           () => adminDatasource.shareInvitationTokenToWhatsApp(
//             token: tToken,
//           ),
//         );
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
//
//   group('SaveInvitationToken', () {
//     const tToken = 'token';
//     test(
//       'Should call [AdminRepo] and return [Right<void>] when successful',
//       () async {
//         when(
//           () => adminDatasource.saveInvitationToken(
//             key: any(named: 'key'),
//           ),
//         ).thenAnswer((_) async => Future.value());
//
//         final result = await adminRepoImpl.saveInvitationToken(key: tToken);
//         expect(result, equals(const Right<dynamic, void>(null)));
//
//         verify(() => adminDatasource.saveInvitationToken(key: tToken));
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//
//     test(
//       'Should call [AdminDatasource] and return [Left<AuthFailure>]',
//       () async {
//         when(
//           () => adminDatasource.saveInvitationToken(
//             key: any(named: 'key'),
//           ),
//         ).thenThrow(
//           const AdminException(message: 'Token is invalid', statusCode: 400),
//         );
//
//         final result = await adminRepoImpl.saveInvitationToken(key: tToken);
//         expect(
//           result,
//           equals(
//             Left<AdminFailure, dynamic>(
//               AdminFailure(message: 'Token is invalid', statusCode: 400),
//             ),
//           ),
//         );
//
//         verify(() => adminDatasource.saveInvitationToken(key: tToken)).called(1);
//         verifyNoMoreInteractions(adminDatasource);
//       },
//     );
//   });
// }
