import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/card_funding_history_id_provider.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

class BreadBrowser extends ConsumerStatefulWidget {
  const BreadBrowser({
    this.initializeCardFundingResponseEntity,
    this.cardFundingPinAuthResponseEntity,
    this.cardFundingAddressAuthResponseEntity,
    super.key,
  });

  final InitializeCardFundingResponseEntity?
      initializeCardFundingResponseEntity;
  final CardFundingPinAuthResponseEntity? cardFundingPinAuthResponseEntity;
  final CardFundingAddressAuthResponseEntity?
      cardFundingAddressAuthResponseEntity;

  @override
  BreadBrowserState createState() => BreadBrowserState();
}

class BreadBrowserState extends ConsumerState<BreadBrowser> {
  late PaymentBloc _paymentBloc;
  InAppWebViewController? webViewController;
  TextEditingController fieldController = TextEditingController();
  String currentUrl = '';

  String getRedirectLink() {
    return widget.initializeCardFundingResponseEntity?.url ??
        widget.cardFundingPinAuthResponseEntity?.url ??
        widget.cardFundingAddressAuthResponseEntity?.url ??
        '';
  }

  String getTransactionId() {
    return widget.initializeCardFundingResponseEntity?.transactionId ??
        widget.cardFundingPinAuthResponseEntity?.transactionId ??
        widget.cardFundingAddressAuthResponseEntity?.transactionId ??
        '';
  }

  @override
  void initState() {
    _paymentBloc = ref.read(paymentBlocProvider);
    final transactionId = getTransactionId();
    final historyId = ref.read(cardFundingHistoryIdProvider);

    _paymentBloc.add(
      UpdateCardFundingHistoryEvent(
        historyId: historyId,
        values: [
          transactionId,
          true,
          DateTime.now().toIso8601String(),
        ],
        culprits: const [
          UpdateCardFundingHistoryCulprit.transactionId,
          UpdateCardFundingHistoryCulprit.isBrowserAuth,
          UpdateCardFundingHistoryCulprit.date,
        ],
      ),
    );

    log('Transaction ID: $transactionId');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _paymentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BreadTextField(
          fieldController: fieldController,
          suffix: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              var url = fieldController.text;
              if (!url.startsWith('http')) {
                url = 'https://$url';
              }
              webViewController?.loadUrl(
                urlRequest: URLRequest(url: WebUri(url)),
              );
              FocusScope.of(context).unfocus(); // Unfocus the address bar
            },
          ),
          onSubmitted: (url) {
            if (!url.startsWith('http')) {
              url = 'https://$url';
            }
            webViewController?.loadUrl(
              urlRequest: URLRequest(url: WebUri(url)),
            );
            FocusScope.of(context).unfocus(); // Unfocus the address bar
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(
                  getRedirectLink(),
                ),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  currentUrl = url.toString();
                  fieldController.text = currentUrl;
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  currentUrl = url.toString();
                  fieldController.text = currentUrl;
                  log('Current URL: $currentUrl');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
