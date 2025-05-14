part of 'cubit.dart';

// root-state
@immutable
class ProductState extends Equatable {
  final ProductFetchState fetch;
  final CategoryFetchState fetchCategory;
  final FetchByIdState fetchById;
  final ProductSearchState search;

  final List<Product>? allProducts;
  final List<String>? categories;

  final ProductCategoryState fetchByCategory;

  final List<Product> displayedProducts;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasReachedMax;

  static const int itemsPerPage = 20;

  const ProductState({
    required this.fetch,
    required this.fetchCategory,
    required this.fetchById,
    required this.search,
    this.allProducts,
    this.categories,

    required this.fetchByCategory,

    this.displayedProducts = const [],
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
    // root-state-props
    fetch,
    fetchCategory,
    fetchById,
    search,
    allProducts,
    categories,

    fetchByCategory,
    displayedProducts,
    currentPage,
    isLoadingMore,
    hasReachedMax,
  ];

  ProductState copyWith({
    ProductFetchState? fetch,
    CategoryFetchState? fetchCategory,
    FetchByIdState? fetchById,
    ProductSearchState? search,
    List<Product>? allProducts,
    List<String>? categories,
    bool? isFiltered,
    Map<String, dynamic>? filters,
    String? uid,
    ProductCategoryState? fetchByCategory,

    List<Product>? displayedProducts,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasReachedMax,

    bool resetPaginationAndProducts = false,
  }) {
    return ProductState(
      fetch: fetch ?? this.fetch,
      fetchCategory: fetchCategory ?? this.fetchCategory,
      fetchById: fetchById ?? this.fetchById,
      search: search ?? this.search,
      allProducts:
          resetPaginationAndProducts ? [] : (allProducts ?? this.allProducts),
      categories: categories ?? this.categories,

      fetchByCategory: fetchByCategory ?? this.fetchByCategory,

      displayedProducts:
          resetPaginationAndProducts
              ? []
              : (displayedProducts ?? this.displayedProducts),
      currentPage:
          resetPaginationAndProducts ? 1 : (currentPage ?? this.currentPage),
      isLoadingMore:
          resetPaginationAndProducts
              ? false
              : (isLoadingMore ?? this.isLoadingMore),
      hasReachedMax:
          resetPaginationAndProducts
              ? false
              : (hasReachedMax ?? this.hasReachedMax),
    );
  }
}

@immutable
class ProductStateDefault extends ProductState {
  const ProductStateDefault()
    : super(
        // root-state-init
        fetchById: const FetchByIdState(),
        fetch: const ProductFetchState(),
        fetchCategory: const CategoryFetchState(),
        fetchByCategory: const ProductCategoryState(),
        search: const ProductSearchState(),

        allProducts: const [],
      );
}
