import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchedProductsProvider = StateProvider<List<String>>((ref) => []);