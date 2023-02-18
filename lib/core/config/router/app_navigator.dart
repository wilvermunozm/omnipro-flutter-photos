import 'package:flutter_modular/flutter_modular.dart';

import '../constants/routes.dart';

void goBack() => Modular.to.pop();

void goToPhotoList() => Modular.to.navigate(photoList);
