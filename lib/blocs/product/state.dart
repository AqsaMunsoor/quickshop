part of 'cubit.dart'; // Assuming this is the top of your state file

// root-state
@immutable
class ProductState extends Equatable {
  final ProductFetchState fetch;
  final CategoryFetchState fetchCategory;
  final FetchByIdState fetchById;
  final ProductSearchState search;

  final List<Product>?
  allProducts; // This will now represent ALL fetched products
  final List<String>? categories;
  final bool isFiltered;
  final Map<String, dynamic>? filters;
  final String? uid;
  final ProductCategoryState fetchByCategory;

  // --- Pagination Fields ---
  final List<Product> displayedProducts; // Products currently shown in the UI
  final int currentPage; // Current page for pagination
  final bool isLoadingMore; // To show a loader at the bottom
  final bool hasReachedMax; // No more products to load

  // --- Constant for pagination ---
  static const int itemsPerPage = 20;

  const ProductState({
    required this.fetch,
    required this.fetchCategory,
    required this.fetchById,
    required this.search,
    this.allProducts, // This will become allProducts internally or on fetch
    this.categories,
    this.isFiltered = false,
    this.filters,
    this.uid,
    required this.fetchByCategory,
    // --- Initialize Pagination Fields ---
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
    isFiltered,
    filters,
    uid,
    fetchByCategory,
    // --- Pagination Props ---
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
    List<Product>? allProducts, // This sets the master list of all products
    List<String>? categories,
    bool? isFiltered,
    Map<String, dynamic>? filters,
    String? uid,
    ProductCategoryState? fetchByCategory,
    // --- Pagination copyWith Params ---
    List<Product>? displayedProducts,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasReachedMax,
    // Helper to reset products and pagination, e.g., on a fresh fetch
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
      isFiltered: isFiltered ?? this.isFiltered,
      filters: filters ?? this.filters,
      uid: uid ?? this.uid,
      fetchByCategory: fetchByCategory ?? this.fetchByCategory,
      // --- Pagination copyWith Logic ---
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
        // products is nullable, defaults to null or initial empty list if needed
        allProducts:
            const [], // Initialize as empty or null based on your preference
        // categories is nullable
        // isFiltered defaults to false
        // filters is nullable
        // uid is nullable
        // --- Pagination Defaults in Super Constructor ---
        // displayedProducts, currentPage, isLoadingMore, hasReachedMax
        // will use their defaults defined in the ProductState constructor
        // i.e., displayedProducts: [], currentPage: 1, etc.
      );
}
