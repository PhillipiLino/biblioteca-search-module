import 'package:biblioteca_components/biblioteca_components.dart' as components;
import 'package:biblioteca_search_module/src/presenter/keys.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../domain/entities/search_book_entity.dart';
import '../store/search_store.dart';
import '../widgets/search_book_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends MainPageState<SearchPage, SearchPageStore> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  _openDetails(SearchBookEntity book) => store.openDetails(book);

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(
      child: components.EmptyList(
        textColor: Colors.white,
        image: Image(image: components.MainIllustrations.error),
        title: 'EITA!',
        message: 'Eita, ocorreu um erro. Tente novamente',
      ),
    );
  }

  Widget _onSuccess(BuildContext context, List<SearchBookEntity>? list) {
    final books = list ?? [];

    if (books.isEmpty && _searchController.text.isEmpty) {
      return const Expanded(
        child: components.EmptyList(
          key: Key(SearchKeys.viewEmptyList),
          textColor: Colors.white,
          image: Image(image: components.MainIllustrations.emptySearch),
          title: '',
          message: '',
        ),
      );
    }

    if (books.isEmpty) {
      return const Expanded(
        child: components.EmptyList(
          key: Key(SearchKeys.viewNotFoundBooks),
          textColor: Colors.white,
          image: Image(image: components.MainIllustrations.termNotFound),
          title: 'Nenhum livro ou autor encontrado',
          message:
              'Desculpe, mas dessa vez não encontramos livro ou autor com o termo buscado. Pode ser sua chance de escrever esse livro!',
        ),
      );
    }

    return Expanded(
      child: PaginationView<SearchBookEntity>(
        key: const Key(SearchKeys.listViewBooks),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        preloadedItems: const [],
        itemBuilder: (
          BuildContext context,
          SearchBookEntity book,
          int position,
        ) {
          return SearchBookItem(
            book,
            position,
            onTap: () => _openDetails(book),
            key: Key(SearchKeys.listBook(position)),
          );
        },
        pageFetch: (position) {
          return store.paginate(_searchController.text, position);
        },
        onError: (dynamic error) => const Center(
          child: Text('Ocorreu um erro inesperado'),
        ),
        onEmpty: const Center(
          child: Text('Nenhum resultado encontrado'),
        ),
        bottomLoader: const Center(
          child: CircularProgressIndicator(),
        ),
        initialLoader: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

    return Scaffold(
      appBar: components.CustomAppBar(title: 'Busca', pageContext: context),
      body: GestureDetector(
        onTap: hideKeyboard,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: components.SearchBar(
                key: const Key(SearchKeys.txtSearchBar),
                hint: 'Digite um livro ou autor',
                controller: _searchController,
                onChanged: store.search,
              ),
            ),
            ScopedBuilder(
              store: store,
              onLoading: _onLoading,
              onState: _onSuccess,
              onError: _onError,
            ),
          ],
        ),
      ),
    );
  }
}
