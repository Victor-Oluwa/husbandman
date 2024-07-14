import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';

final stateCounterProvider = StateProvider((ref) => 0);

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
    final id = getTransactionId();
    final redirect = getRedirectLink();

    log('Transaction ID: $id');
    log('Redirect url: $redirect');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.invalidate(stateCounterProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int stateCounter = ref.watch(stateCounterProvider);
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
