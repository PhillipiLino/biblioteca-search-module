import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:biblioteca_network_sdk/models.dart';
import 'package:biblioteca_search_module/src/data/repositories/search_books_repository_implementation.dart';
import 'package:biblioteca_search_module/src/domain/entities/search_book_entity.dart';
import 'package:biblioteca_search_module/src/domain/entities/search_params.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/google_service_mock.dart';

main() {
  late SearchBooksRepositoryImplementation repository;
  late GoogleService service;

  const tException = RequestException(12, 'Teste', null);
  const sdkBookModel = GoogleBookModel();
  const searchBooksResponse = GoogleSearchModel(
    items: [sdkBookModel],
    kind: 'kind',
    totalItems: 1,
  );

  const tParams = SearchParams(filter: 'filter', page: 1);

  setUp(() {
    registerFallbackValue(const GoogleSearchRequest(startIndex: 1, term: ''));
    service = GoogleServiceMock();
    repository = SearchBooksRepositoryImplementation(service);
  });

  test(
      'Should return list of SearchBookEntity when calls search books has success',
      () async {
    // Arrange
    when(() => service.searchBooks(any())).thenAnswer(
      (_) async => searchBooksResponse,
    );

    // Act
    final result = await repository.searchBooks(tParams);

    // Assert
    final expectedResult = SearchBookEntity.fromGoogleModel(sdkBookModel);
    final finalResult = result.getOrElse(() => []);

    expect(finalResult, [expectedResult]);

    verify(() => service.searchBooks(tParams.toSDK())).called(1);
  });

  test('Should return a server failure when the search books is unsuccessful',
      () async {
    // Arrange
    when(() => service.searchBooks(any())).thenThrow(tException);

    // Act
    final result = await repository.searchBooks(tParams);

    // Assert
    expect(result, Left(ServerFailure(tException.rawMessage ?? '')));
    verify(() => service.searchBooks(tParams.toSDK())).called(1);
  });

  test(
      'Should return a null response failure when the call search books return null',
      () async {
    // Arrange
    when(() => service.searchBooks(any())).thenAnswer((_) async => null);

    // Act
    final result = await repository.searchBooks(tParams);

    // Assert
    expect(result, const Left(NullResponseFailure()));
    verify(() => service.searchBooks(tParams.toSDK())).called(1);
  });
}
