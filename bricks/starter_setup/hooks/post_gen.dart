import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:process_run/shell.dart';

void run(HookContext context) async {
  var name = context.vars['name'];
  context.logger.info('installed brick for $name!');
  installI10n(context);
}

Future<void> installI10n(HookContext context) async {
  var shell = Shell();

  //await shell.run('flutter pub run intl_utils:generate');

  await shell.run('''
# Display some text
flutter pub get

# Display some text
dart run intl_utils:generate

''');
  final Map<String, String> jsonData = {
    "kindlyTryAgain": "Kindly try again, poor internet connection",
    "requestCancelled": "Request cancelled",
    "noInternetConnection": "No internet connection",
    "anErrorOccurred": "An error occurred"
  };
  String jsonString = jsonEncode(jsonData);
  final String filePath = "lib/I10n/intl_en.arb";
  final file = File(filePath);
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  await file.writeAsString(jsonString);
}
