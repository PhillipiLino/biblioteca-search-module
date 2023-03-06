import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

import '../entities/search_book_entity.dart';
import '../entities/search_params.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<SearchBookEntity>>> searchBooks(
    SearchParams params,
  );
}
