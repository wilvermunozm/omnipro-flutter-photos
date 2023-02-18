import 'package:flutter_modular/flutter_modular.dart';

import 'core/config/router/routes.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => appRoutes;
}
