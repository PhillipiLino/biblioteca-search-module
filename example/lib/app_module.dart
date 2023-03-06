// coverage:ignore-file
// ignore_for_file: depend_on_referenced_packages

import 'package:biblioteca_network_sdk/clients.dart';
import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:example/app_widget_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'event_controller.dart';
import 'trackers.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<AppWidgetStore>((i) => AppWidgetStore()),
    Bind.singleton<EventBus>((i) => EventBus()),
    Bind<Trackers>((i) => Trackers()),
    Bind.singleton<EventController>((i) => EventController(
          i.get(),
          i.get(),
        )),
    Bind<IClient>((i) {
      return DioClient(typesToLog: [], interceptor: null, errorReport: null);
    }),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Modular.initialRoute,
          module: SearchModule(),
          transition: TransitionType.rightToLeft,
        ),
      ];
}
