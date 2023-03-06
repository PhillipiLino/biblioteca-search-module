import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';

import '../../domain/entities/search_book_entity.dart';
import '../../domain/entities/search_params.dart';
import '../../domain/repositories/books_repository.dart';

class SearchBooksRepositoryImplementation implements ISearchRepository {
  final GoogleService service;

  SearchBooksRepositoryImplementation(this.service);

  @override
  Future<Either<Failure, List<SearchBookEntity>>> searchBooks(
    SearchParams params,
  ) async {
    try {
      final result = await service.searchBooks(params.toSDK());
      if (result == null) return const Left(ServerFailure(''));

      final parsed = result.items
          ?.map((e) => SearchBookEntity.fromGoogleModel(e))
          .toList();
      return Right(parsed ?? []);
    } catch (e) {
      return const Left(ServerFailure(''));
    }
  }
}
