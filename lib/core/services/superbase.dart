import 'package:husbandman/core/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SuperBaseInit {

  factory SuperBaseInit() => _instance;
  SuperBaseInit._internal();
  static final SuperBaseInit _instance = SuperBaseInit._internal();

  final cc = Supabase.initialize(
    url: kSuperbBaseUrl,
    anonKey: kSuperBaseAnon,
  );

  final client = SupabaseClient(
      kSuperbBaseUrl,
      kSuperBaseAnon,
  );

}
