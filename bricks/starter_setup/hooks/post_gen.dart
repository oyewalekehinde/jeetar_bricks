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

''');
}
