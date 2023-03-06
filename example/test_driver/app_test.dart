import 'package:biblioteca_search_module/biblioteca_search_module.dart';
import 'package:flutter_driver/flutter_driver.dart' as flutter_driver;
import 'package:flutter_test/flutter_test.dart';

void main() {
  flutter_driver.FlutterDriver? driver;
  const waitTimeout = Duration(seconds: 10);

  const successTerm = 'homem aranha';
  const wrongTerm = 'jdsfk';

  setUpAll(() async {
    driver = await flutter_driver.FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver?.close();
    }
  });

  insertSearchText(String term) async {
    await driver?.tapElementByKey(SearchKeys.txtSearchBar);
    await driver?.enterText(term);
  }

  test('Do search with success', () async {
    await driver?.waitElementByKey(SearchKeys.viewEmptyList);

    insertSearchText(successTerm);

    await driver?.waitFor(
      flutter_driver.find.text(successTerm),
      timeout: waitTimeout,
    );

    await driver?.waitElementByKey(SearchKeys.listViewBooks);

    insertSearchText('');
  });

  test('Do search and not found books', () async {
    await driver?.waitElementByKey(SearchKeys.viewEmptyList);

    insertSearchText(wrongTerm);

    await driver?.waitFor(
      flutter_driver.find.text(wrongTerm),
      timeout: waitTimeout,
    );

    await driver?.waitElementByKey(SearchKeys.viewNotFoundBooks);

    insertSearchText('');
  });

  test('Do search and tap first founded book', () async {
    await driver?.waitElementByKey(SearchKeys.viewEmptyList);
    insertSearchText(successTerm);

    await driver?.waitFor(
      flutter_driver.find.text(successTerm),
      timeout: waitTimeout,
    );

    await driver?.waitElementByKey(SearchKeys.listViewBooks);

    await driver?.tapElementByKey(SearchKeys.listBook(0));

    await driver?.waitElementByKey('details_page');
  });
}

extension FlutterDriverExtension on flutter_driver.FlutterDriver {
  static const waitTimeout = Duration(seconds: 10);

  waitElementByKey(String key) async {
    return await waitFor(
      flutter_driver.find.byValueKey(key),
      timeout: waitTimeout,
    );
  }

  tapElementByKey(String key) async {
    return await tap(flutter_driver.find.byValueKey(key));
  }
}
