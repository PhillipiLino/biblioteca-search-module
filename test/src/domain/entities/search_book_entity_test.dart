import 'package:biblioteca_network_sdk/models.dart';
import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tId = 'id';
  const tName = 'name';
  const tAuthor = 'author';
  const tImagePath = 'imagePath';
  const tPages = 10;

  test('Create SearchBookEntity by SDK model', () {
    // Given
    const sdkModel = GoogleBookModel(
      id: tId,
      title: tName,
      authors: [tAuthor],
      imagePath: tImagePath,
    );

    // When
    final entity = SearchBookEntity.fromGoogleModel(sdkModel);

    // Then
    expect(entity.id, sdkModel.id);
    expect(entity.name, sdkModel.title);
    expect(entity.imagePath, sdkModel.imagePath);
    expect(entity.author, sdkModel.authors?.first);
  });

  test('Test equals', () {
    // Arrange
    const entity1 = SearchBookEntity(
      name: tName,
      imagePath: tImagePath,
      id: tId,
      author: tAuthor,
      pages: tPages,
    );

    const entity2 = SearchBookEntity(
      name: tName,
      imagePath: tImagePath,
      id: tId,
      author: tAuthor,
      pages: tPages,
    );
    // Assert
    expect(entity1 == entity2, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    const entity1 = SearchBookEntity(
      name: tName,
      imagePath: tImagePath,
      id: tId,
      author: tAuthor,
      pages: tPages,
    );
    const entity2 = SearchBookEntity(
      name: tName,
      imagePath: tImagePath,
      id: tId,
      author: 'tauthor',
      pages: 2,
    );
    // Assert
    expect(entity1 == entity2, isFalse);
  });
}
