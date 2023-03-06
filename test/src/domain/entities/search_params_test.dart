import 'package:biblioteca_search_module/src/domain/entities/search_params.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tPage = 1;
  const tFilter = 'filter';
  const tPagSize = 20;

  test('Create SearchParams by SDK model', () {
    // Act
    const entity = SearchParams(
      filter: tFilter,
      page: tPage,
      pageSize: tPagSize,
    );

    // Assert
    expect(entity.filter, tFilter);
    expect(entity.page, tPage);
    expect(entity.pageSize, tPagSize);
  });

  test('Transform SearchParams to SDK request', () {
    // Arrange
    const entity = SearchParams(
      filter: tFilter,
      page: tPage,
      pageSize: tPagSize,
    );

    // Act
    final sdkRequest = entity.toSDK();

    // Assert
    expect(sdkRequest.term, tFilter);
    expect(sdkRequest.startIndex, tPage ~/ tPagSize);
    expect(sdkRequest.maxResults, tPagSize);
  });

  test('Test equals', () {
    // Arrange
    const entity1 = SearchParams(
      filter: tFilter,
      page: tPage,
      pageSize: tPagSize,
    );

    const entity2 = SearchParams(
      filter: tFilter,
      page: tPage,
      pageSize: tPagSize,
    );
    // Assert
    expect(entity1 == entity2, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    const entity1 = SearchParams(
      filter: tFilter,
      page: tPage,
      pageSize: tPagSize,
    );

    const entity2 = SearchParams(
      filter: tFilter,
      page: tPage,
      pageSize: 0,
    );
    // Assert
    expect(entity1 == entity2, isFalse);
  });
}
