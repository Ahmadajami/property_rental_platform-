class PagingCriteria {
  final String expand;
  final String filter;
  final int page;
  final int perPage;
  final String? sort;

  const PagingCriteria({
    this.expand = "owner",
    this.filter = "availability_status=true",
    this.page = 1,
    this.perPage = 30,
    this.sort,
  });

  // Remove setters (no need to modify existing object)

  PagingCriteria copyWith({
    String? expand,
    String? filter,
    int? page,
    int? perPage,
    String? sort,
  }) {
    return PagingCriteria(
      expand: expand ?? this.expand,
      filter: filter ?? this.filter,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      sort: sort ?? this.sort,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PagingCriteria) return false;
    return expand == other.expand &&
        filter == other.filter &&
        page == other.page &&
        perPage == other.perPage &&
        sort == other.sort;
  }

  @override
  int get hashCode =>
      expand.hashCode ^
      filter.hashCode ^
      page.hashCode ^
      perPage.hashCode ^
      sort.hashCode;

  @override
  String toString() {
    return 'PagingCriteria(expand: $expand, filter: $filter, page: $page, perPage: $perPage, sort: $sort)';
  }
}
