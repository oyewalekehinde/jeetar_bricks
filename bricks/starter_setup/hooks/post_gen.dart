import 'package:mason/mason.dart';
import 'package:process_run/shell.dart';

void run(HookContext context) async {
  context.logger.info('installed brick for {{name}}!');
  installI10n(context);
}

Future<void> installI10n(HookContext context) async {
  var shell = Shell();

  await shell.run('dart run intl_utils:generate');
  context.logger.info('Successfully setup I10n');
}
