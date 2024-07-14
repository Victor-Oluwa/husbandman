import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedProductCategoryProvider =
    StateProvider<String>((ref) => 'No Category');
