import 'dart:async';

class SearchTextBloc {
  StreamController _searchTextController = StreamController<String>.broadcast();

  Stream get getSearchText => _searchTextController.stream;

  dispose() {
    _searchTextController.close();
  }

  updateSearchText(String searchText) {
    _searchTextController.sink.add(searchText);
  }
}

final searchTextBloc = SearchTextBloc();