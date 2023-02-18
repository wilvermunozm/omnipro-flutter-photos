import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'core/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    return runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  });
}
