import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

import '../entities/search_book_entity.dart';
import '../entities/search_params.dart';
import '../repositories/books_repository.dart';

class SearchBooksUsecase
    implements Usecase<List<SearchBookEntity>, SearchParams> {
  final ISearchRepository repository;

  SearchBooksUsecase(this.repository);

  @override
  Future<Either<Failure, List<SearchBookEntity>>> call(SearchParams params) {
    return repository.searchBooks(params);
  }
}
