import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:commons_tools_sdk/commons_tools_sdk.dart';

import '../../domain/entities/search_params.dart';
import '../../domain/usecases/search_books_usecase.dart';

class SearchPageStore extends MainStore<List<SearchBookEntity>> {
  final SearchBooksUsecase usecase;
  final _debouncer = Debouncer(milliseconds: 800);

  SearchPageStore(
    this.usecase,
    EventBus? eventBus,
  ) : super(eventBus, []);

  search(String filter) async {
    if (filter.isEmpty) {
      update([]);
      setLoading(false);
    }

    _debouncer.run(() {
      if (filter.isEmpty) return;
      final params = SearchParams(filter: filter, page: 0);
      executeEither(() => DartzEitherAdapter.adapter(usecase(params)));
    });
  }

  Future<List<SearchBookEntity>> paginate(String filter, int page) async {
    final params = SearchParams(filter: filter, page: page);
    final result = await usecase(params);
    result.fold((error) => setError(error), (success) => {});

    if (result.isRight()) {
      return result.getOrElse(() => <SearchBookEntity>[]);
    }

    return [];
  }

  openDetails(SearchBookEntity book) {
    eventBus?.fire(EventInfo(
      name: SearchModuleEvents.searchOpenDetails,
      data: book,
    ));
  }

  void dispose() {
    _debouncer.dispose();
  }
}
