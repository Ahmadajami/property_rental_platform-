import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = NotifierProvider<SearchQuery, String?>(() => SearchQuery(),);
class SearchQuery extends Notifier<String?> {
  @override
  String? build() {
    // Inside "build", we return the initial state of the counter.
    return null;
  }

  void setQuery(String? query) {
    state=query;
  }
}