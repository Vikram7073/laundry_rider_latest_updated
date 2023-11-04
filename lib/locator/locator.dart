import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../router/router.gr.dart';
import 'locator.config.dart';


final locator = GetIt.instance;

@injectableInit
Future<void> setupLocator() async {
      _init(locator);
      $initGetIt(locator);
}

void _init(GetIt locator) {
      locator.registerLazySingleton<AppRouter>(() => AppRouter());
}