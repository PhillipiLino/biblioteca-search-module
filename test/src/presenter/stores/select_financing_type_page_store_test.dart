import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:biblioteca_search_module/src/domain/entities/search_params.dart';
import 'package:biblioteca_search_module/src/domain/usecases/search_books_usecase.dart';
import 'package:biblioteca_search_module/src/presenter/store/search_store.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/search_books_usecase_mock.dart';

main() {
  late SearchBooksUsecase usecase;
  late SearchPageStore store;

  setUp(() {
    usecase = SearchBooksUsecaseMock();
    store = SearchPageStore(usecase, null);
  });

  setUpAll(() {
    registerFallbackValue(const SearchParams(filter: '', page: 1));
  });

  const tFailure = ServerFailure('error_message');
  const tFilter = 'filter';
  const tResponse = [
    SearchBookEntity(
      name: 'name',
      imagePath: 'image',
      id: 'id',
      author: 'author',
      pages: 3,
    ),
  ];

  test('Should return list of SearchBookEntity from the usecase', () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => const Right(tResponse));

    // Act
    final result = store.search(tFilter);

    // Assert
    store.observer(onState: (state) {
      const expectedParams = SearchParams(filter: tFilter, page: 0);
      verify(() => usecase.call(expectedParams)).called(1);
      expect(result, completes);
      expect(state, tResponse);
    });
  });

  test('Should return a failure from the usecase when there is an error',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = store.search(tFilter);

    // Assert
    store.observer(onError: (error) {
      const expectedParams = SearchParams(filter: tFilter, page: 0);
      verify(() => usecase.call(expectedParams)).called(1);
      expect(result, completes);
      expect(error, tFailure);
    });
  });
}
