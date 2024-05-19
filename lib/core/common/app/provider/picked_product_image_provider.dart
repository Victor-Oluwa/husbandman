import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final pickedProductImageProvider = StateProvider<List<File>?>(
  (ref) => null,
);
