// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:husbandman/core/common/app/models/order_model.dart';
// import 'package:husbandman/core/error/failure.dart';
// import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
// import 'package:husbandman/src/admin/domain/use-cases/fetch_all_orders.dart';
// import 'package:mocktail/mocktail.dart';
//
// import 'mock_admin_repo.dart';
//
// void main() {
//   late AdminRepo adminRepo;
//   late FetchAllOrders usecase;
//
//   final tOrders = [const OrderModel.empty()];
//
//   setUp(() {
//     adminRepo = MockAdminRepo();
//     usecase = FetchAllOrders(adminRepo);
//   });
//
//   group('Fetch All Orders', () {
//     test('Should call [AdminRepo] and return [Right(List<Order>)]', () async {
//       when(() => adminRepo.fetchAllOrders()).thenAnswer(
//             (_) async => Right(tOrders),
//       );
//
//       final result = await usecase();
//       expect(
//         result,
//         equals(
//            Right<dynamic, List<OrderModel>>(tOrders),
//         ),
//       );
//
//       verify(() => adminRepo.fetchAllOrders());
//       verifyNoMoreInteractions(adminRepo);
//     });
//
//     test('Should call [AdminRepo] and return [Left(ServerFailure)]', () async {
//       when(() => adminRepo.fetchAllOrders())
//           .thenAnswer(
//             (_) async => Left(
//           ServerFailure(
//               message: 'Failed to fetch orders', statusCode: 123,),
//         ),
//       );
//
//       final result = await usecase();
//       expect(
//         result,
//         equals(
//           Left<ServerFailure, dynamic>(
//             ServerFailure(
//               message: 'Failed to fetch orders', statusCode: 123,
//             ),
//           ),
//         ),
//       );
//
//       verify(() => adminRepo.fetchAllOrders());
//       verifyNoMoreInteractions(adminRepo);
//     });
//   });
// }
