import 'package:biblioteca_search_module/src/domain/entities/search_book_entity.dart';
import 'package:biblioteca_search_module/src/domain/entities/search_params.dart';
import 'package:biblioteca_search_module/src/domain/repositories/books_repository.dart';
import 'package:biblioteca_search_module/src/domain/usecases/search_books_usecase.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/search_books_repository_mock.dart';

main() {
  late SearchBooksUsecase usecase;
  late ISearchRepository repository;

  setUp(() {
    repository = SearchBooksRepositoryMock();
    usecase = SearchBooksUsecase(repository);
  });

  setUpAll(() {
    registerFallbackValue(const SearchParams(filter: '', page: 1));
  });

  const tFailure = ServerFailure('error_message');
  const tParams = SearchParams(filter: 'filter', page: 10);
  const tResponse = [
    SearchBookEntity(
      name: 'name',
      imagePath: 'image',
      id: 'id',
      author: 'author',
      pages: 3,
    )
  ];

  test('Should get SearchBookEntity list from the repository', () async {
    // Arrange
    when(() => repository.searchBooks((any())))
        .thenAnswer((_) async => const Right(tResponse));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, const Right(tResponse));
    verify(() => repository.searchBooks(tParams)).called(1);
  });

  test('Should return a ServerFailure when don\'t succeed', () async {
    // Arrange
    when(() => repository.searchBooks((any())))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => repository.searchBooks(tParams)).called(1);
  });
}
