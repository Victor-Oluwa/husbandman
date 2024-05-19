import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final invitationKeyProvider =
    StateNotifierProvider<InvitationKeyNotifier, String>(
  (ref) => InvitationKeyNotifier(),
);

class InvitationKeyNotifier extends StateNotifier<String> {
  InvitationKeyNotifier() : super('');

void cacheInvitationToken({required String token}) {
     state = token;
     log('Passed key: $token');
     log('Cached key: $state');
  }
}
