import 'package:flutter_modular/flutter_modular.dart';
import 'package:omnipro/features/photo_list/presentation/photo_list_page.dart';

import '../constants/routes.dart';

List<ModularRoute> get appRoutes => [
      ChildRoute(splash, child: (context, args) => const PhotoListPage()),
      ChildRoute(photoList, child: (context, args) => const PhotoListPage()),
    ];
