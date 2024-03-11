import 'dart:io';

String fixtures({required String folder, required String fileName}) =>
    File('test/fixtures/$folder/$fileName').readAsStringSync();
