import 'dart:convert';
import 'dart:developer';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/common/app/models/payment_card_model.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/payment_card_provider.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/data/datasource/payment_datasource.dart';
import 'package:husbandman/src/payment/data/model/card_funding_address_auth_response.dart';
import 'package:husbandman/src/payment/data/model/card_funding_pin_auth_response.dart';
import 'package:husbandman/src/payment/data/model/initialize_card_funding_response_model.dart';

const kAddNewCardEndpoint = '/card/add-new';
const kDeleteCardEndpoint = '/card/delete';
const kFetchAllCardsEndpoint = '/cards/fetch-all';
const kInitializeCardFundingEndpoint = '/card/fund/initialise';
const kValidateCardFundingEndpoint = '/card/validate-otp';
const kCardFundingPinAuthEndpoint = '/card/authorize-pin';
const kCardFundingAddressAuthEndpoint = '/card/authorize-address';
const kCardFundingVerificationEndpoint = '/card/funding/verify';

class PaymentDatasourceImpl implements PaymentDatasource {
  PaymentDatasourceImpl({required Dio dio, required Ref ref})
      : _dio = dio,
        _ref = ref;

  final Dio _dio;
  final Ref _ref;

  @override
  Future<PaymentCardModel> addNewCard({
    required String holderName,
    required String cardNumber,
    required String expiryDate,
    required String ccv,
    required String type,
    required String ownerId,
  }) async {
    try {
      final response = await _dio.post<DataMap>(
        '$kBaseUrl$kAddNewCardEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({
          'holderName': holderName,
          'cardNumber': cardNumber,
          'expiryDate': expiryDate,
          'ccv': ccv,
          'type': type,
          'ownerId': ownerId,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (response.data == null) {
        throw PaymentException(
          message: 'Response returned null',
          statusCode: response.statusCode ?? 500,
        );
      }

      final card = PaymentCardModel.fromMap(response.data!);
      return card;
    } on PaymentException catch (e) {
      rethrow;
    } catch (e) {
      throw PaymentException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> deleteCard(String cardId) async {
    try {
      final response = await _dio.post<String>(
        '$kBaseUrl$kDeleteCardEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({
          'cardId': cardId,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (response.data == null) {
        throw const PaymentException(
          message: 'Response returned null',
          statusCode: 500,
        );
      }
    } on PaymentException catch (e) {
      rethrow;
    } catch (e) {
      throw PaymentException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<PaymentCardModel>> fetchCards(String userId) async {
    try {
      final response = await _dio.post(
        '$kBaseUrl$kFetchAllCardsEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({
          'ownerId': userId,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }
      if (response.data == null) {
        throw const PaymentException(
          message: 'Fetch card response returned null',
          statusCode: 500,
        );
      }

      // Explicitly casting response.data to List<dynamic> first and then to List<Map<String, dynamic>>
      final responseData = response.data as List<dynamic>;
      final dataMaps =
          responseData.map((e) => e as Map<String, dynamic>).toList();

      // Now mapping the list of maps to PaymentCardModel objects
      final result = dataMaps.map(PaymentCardModel.fromMap).toList();

      return result;
    } on PaymentException catch (e) {
      rethrow;
    } catch (e) {
      throw PaymentException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> setCard({
    required List<PaymentCardEntity> cards,
    required bool replaceList,
  }) async {
    try {
      if (replaceList) {
        _ref.read(paymentCardProvider.notifier).updateCardList(cards);
        return;
      }
      _ref.read(paymentCardProvider.notifier).addNewCard(cards);
    } on PaymentException catch (e) {
      rethrow;
    } catch (e) {
      throw PaymentException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<InitializeCardFundingResponse> initializeCardFunding({
    required String cardNumber,
    required String cvv,
    required String expiryYear,
    required String expiryMonth,
    required String currency,
    required String amount,
    required String redirectUrl,
    required String fullName,
    required String email,
    required String phone,
    required String ref,
  }) async {
    try {
      final response = await _dio
          .post<DataMap>(
            '$kBaseUrl$kInitializeCardFundingEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode({
              'ref': ref,
              'phone': phone,
              'email': email,
              'fullName': fullName,
              'redirectUrl': redirectUrl,
              'amount': amount,
              'currency': currency,
              'expiryMonth': expiryMonth,
              'expiryYear': expiryYear,
              'cvv': cvv,
              'cardNumber': cardNumber,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      final message = response.data?['message'].toString();
      final payload = response.data?['payload'] as DataMap?;
      final url = response.data?['url'] as String?;
      final transactionId = response.data?['transactionId'].toString();

      if (message == null) {
        throw const PaymentException(
          message: 'Payment Initialization returned a null value for message',
          statusCode: 500,
        );
      }
      switch (message) {
        case 'PIN required':
          if (payload == null) {
            throw const PaymentException(
              message:
                  'Payment Initialization returned a null value for payload',
              statusCode: 500,
            );
          }
          return InitializeCardFundingResponse(
              message: message, payload: payload);
        case 'Redirecting':
          if (url == null || transactionId == null) {
            throw const PaymentException(
              message: 'Payment Initialization returned a null '
                  'value for either url or transaction ID',
              statusCode: 500,
            );
          }
          return InitializeCardFundingResponse(
            message: message,
            url: url,
            transactionId: transactionId,
          );

        case 'Address required':
          if (payload == null) {
            throw const PaymentException(
              message:
                  'Payment Initialization returned a null value for payload',
              statusCode: 500,
            );
          }
          return InitializeCardFundingResponse(
            message: message,
            payload: payload,
          );

        case 'verify':
          if (transactionId == null) {
            throw const PaymentException(
              message: 'Initialize Card Funding: transactionId is'
                  " null for 'No authentication required' card status",
              statusCode: 500,
            );
          }
          return InitializeCardFundingResponse(
            message: message,
            transactionId: transactionId,
          );
        default:
          throw const PaymentException(
            message: 'Failed to initialize payment',
            statusCode: 500,
          );
      }
    } on PaymentException catch (e) {
      rethrow;
    } on DioException catch (e) {
      if (e.response != null) {
        throw PaymentException(
          message: e.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw PaymentException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw PaymentException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<CardFundingPinAuthResponse> cardFundingPinAuth({
    required String pin,
    required DataMap payload,
  }) async {
    try {
      final response = await _dio
          .post<DataMap>(
            '$kBaseUrl$kCardFundingPinAuthEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode({
              'pin': pin,
              'payload': payload,
            }),
          )
          .timeout(const Duration(seconds: 30));

      final result = response.data;
      if (result == null) {
        throw PaymentException(
          message: 'Response data is null',
          statusCode: response.statusCode ?? 500,
        );
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: result.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      return _parseCardFundingPinResponse(result);
    } on DioException catch (e) {
      if (e.response != null) {
        throw PaymentException(
          message:
              e.response?.data?.toString() ?? 'Error without response data',
          statusCode: e.response?.statusCode ?? 500,
        );
      } else {
        throw PaymentException(
          message: e.message ?? 'Unknown DioException',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw PaymentException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  CardFundingPinAuthResponse _parseCardFundingPinResponse(DataMap result) {
    final message = result['message']?.toString() ?? '';
    final transactionId = result['transactionId']?.toString() ?? '';
    final url = result['url']?.toString() ?? '';
    final info = result['info']?.toString() ?? '';
    final status = result['status']?.toString() ?? '';
    final ref = result['ref']?.toString() ?? '';

    switch (message) {
      case 'otp':
        return CardFundingPinAuthResponse(
          message: message,
          transactionId: transactionId,
          ref: ref,
          status: status,
          info: info,
        );

      case 'redirect':
        return CardFundingPinAuthResponse(
          message: message,
          transactionId: transactionId,
          info: info,
          url: url,
          status: status,
        );
      case 'verify':
        return CardFundingPinAuthResponse(
          message: message,
          transactionId: transactionId,
        );

      default:
        throw const PaymentException(
          message: 'Pin verification failed',
          statusCode: 500,
        );
    }
  }

  @override
  Future<CardFundingAddressAuthResponse> cardFundingAddressAuth({
    required DataMap payload,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  }) async {
    try {
      final response = await _dio
          .post<DataMap>(
            '$kBaseUrl$kCardFundingAddressAuthEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode({
              'payload': payload,
              'city': city,
              'address': address,
              'state': state,
              'country': country,
              'zipcode': zipCode,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: response.data?.toString() ?? 'Unknown error',
          statusCode: response.statusCode ?? 500,
        );
      }

      final result = response.data;
      log('Address auth database: $result');
      if (result == null) {
        throw PaymentException(
          message: 'Response data is null',
          statusCode: response.statusCode ?? 500,
        );
      }

      return _parseCardFundingAddressResponse(result);
    } on DioException catch (e) {
      if (e.response != null) {
        throw PaymentException(
          message:
              e.response?.data?.toString() ?? 'Error without response data',
          statusCode: e.response?.statusCode ?? 500,
        );
      } else {
        throw PaymentException(
          message: e.message ?? 'Unknown DioException',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw PaymentException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  CardFundingAddressAuthResponse _parseCardFundingAddressResponse(DataMap result) {
    final message = result['message']?.toString() ?? '';
    final transactionId = result['transactionId']?.toString() ?? '';
    final url = result['url']?.toString() ?? '';
    final info = result['info']?.toString() ?? '';
    final status = result['status']?.toString() ?? '';
    final ref = result['ref']?.toString() ?? '';

    switch (message) {
      case 'otp':
        return CardFundingAddressAuthResponse(
          message: message,
          transactionId: transactionId,
          ref: ref,
          status: status,
          info: info,
        );

      case 'redirect':
        return CardFundingAddressAuthResponse(
          message: message,
          transactionId: transactionId,
          info: info,
          url: url,
          status: status,
        );
      case 'verify':
        return CardFundingAddressAuthResponse(
          message: message,
          transactionId: transactionId,
        );
      default:
        throw const PaymentException(
          message: 'Authentication with address failed',
          statusCode: 500,
        );
    }
  }

  @override
  Future<String> cardFundingOtpValidation({
    required String otp,
    required String ref,
  }) async {
    try {
      final response = await _dio
          .post<String>(
            '$kBaseUrl$kValidateCardFundingEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode({
              'otp': otp,
              'flw_ref': ref,
            }),
          )
          .timeout(const Duration(seconds: 30));

      final result = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: result.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (result == null) {
        throw PaymentException(
          message: 'Null was returned',
          statusCode: response.statusCode ?? 500,
        );
      }

      return jsonDecode(result).toString();
    } on PaymentException catch (e) {
      rethrow;
    } on DioException catch (e) {
      if (e.response != null) {
        throw PaymentException(
          message: e.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw PaymentException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw PaymentException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<String> cardFundingVerification({
    required String transactionId,
  }) async {
    try {
      final response = await _dio
          .post<String>(
            '$kBaseUrl$kCardFundingVerificationEndpoint',
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
            data: jsonEncode({
              'transactionId': transactionId,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw PaymentException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }
      final result = response.data;

      if (result == null) {
        throw const PaymentException(
          message: 'cardFundingVerification returned null',
          statusCode: 500,
        );
      }

      return jsonDecode(result).toString();
    } on PaymentException catch (e) {
      rethrow;
    } on DioException catch (e) {
      if (e.response != null) {
        throw PaymentException(
          message: e.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw PaymentException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw PaymentException(message: e.toString(), statusCode: 500);
    }
  }
}
