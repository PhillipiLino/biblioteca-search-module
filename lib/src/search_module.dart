import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:clean_architecture_utils/modular.dart';

import 'data/repositories/search_books_repository_implementation.dart';
import 'domain/usecases/search_books_usecase.dart';
import 'presenter/pages/search_page.dart';
import 'presenter/store/search_store.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((inject) => GoogleService(inject.get())),
    Bind((inject) => SearchStore(inject.get(), inject.get())),
    Bind((inject) => SearchBooksUsecase(inject.get())),
    Bind((inject) => SearchBooksRepositoryImplementation(inject.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SearchPage(),
    ),
  ];
}
